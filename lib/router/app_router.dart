import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/data/session.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';

part 'app_router.g.dart';

/// Where sign-in gates *doing*, not looking.
///
/// Public: welcome, sign-in, discover, drive, organisation, pledge and
/// certificate pages, plus the tabs themselves (they render a signed-out
/// state). Gated: onboarding, manage, claim, name edit. The original target
/// is carried through `from=` so a poster QR that leads to sign-in still
/// lands on the pledge afterwards.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final notifier = _SessionListenable();
  ref.listen<SessionState>(sessionControllerProvider, (_, _) => notifier.notify());
  ref.onDispose(notifier.dispose);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
    refreshListenable: notifier,
    routes: $appRoutes,
    redirect: (context, state) => _redirect(ref.read(sessionControllerProvider), state),
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(),
      body: ErrorView(error: const _RouteNotFound(), onRetry: () => const DiscoverRoute().go(context)),
    ),
  );
}

class _RouteNotFound implements Exception {
  const _RouteNotFound();
  @override
  String toString() => 'NOT_FOUND';
}

String? _redirect(SessionState s, GoRouterState state) {
  final uri = state.uri;
  final path = uri.path;
  final here = uri.toString();
  final from = _safeFrom(uri.queryParameters['from']);

  final isAuth = path == '/sign-in' || path == '/welcome';
  final isOnboarding = path.startsWith('/onboarding');
  final isGated = isOnboarding ||
      path.startsWith('/manage') ||
      path == '/claim' ||
      path == '/profile/name';

  if (!s.isSignedIn) {
    if (isGated) return SignInRoute(from: from ?? here).location;
    if (path == '/') return s.welcomeSeen ? const DiscoverRoute().location : const WelcomeRoute().location;
    return null;
  }

  // Signed in from here on.
  if (s.needsName) {
    if (path == '/onboarding/name') return null;
    final target = from ?? (isAuth || isOnboarding || path == '/' ? null : here);
    return OnboardingNameRoute(from: target).location;
  }
  if (s.needsIntent) {
    if (path == '/onboarding/intent') return null;
    final target = from ?? (isAuth || isOnboarding || path == '/' ? null : here);
    return OnboardingIntentRoute(from: target).location;
  }
  if (isAuth || isOnboarding || path == '/') {
    return from ?? const DiscoverRoute().location;
  }
  // Manage sub-pages need coordinator rights; the hub itself explains how to
  // get them.
  if (path.startsWith('/manage/') && path != '/manage/org/new' && !s.isCoordinator) {
    return const ManageRoute().location;
  }
  return null;
}

/// Only in-app paths are honoured; never an external URL.
String? _safeFrom(String? from) {
  if (from == null || from.isEmpty) return null;
  if (!from.startsWith('/') || from.startsWith('//')) return null;
  if (from.startsWith('/sign-in') || from.startsWith('/welcome') || from.startsWith('/onboarding')) return null;
  return from;
}

class _SessionListenable extends ChangeNotifier {
  void notify() => notifyListeners();
}
