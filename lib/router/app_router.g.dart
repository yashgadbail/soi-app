// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Where sign-in gates *doing*, not looking.
///
/// Public: welcome, sign-in, discover, drive, organisation, pledge and
/// certificate pages, plus the tabs themselves (they render a signed-out
/// state). Gated: onboarding, manage, claim, name edit. The original target
/// is carried through `from=` so a poster QR that leads to sign-in still
/// lands on the pledge afterwards.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// Where sign-in gates *doing*, not looking.
///
/// Public: welcome, sign-in, discover, drive, organisation, pledge and
/// certificate pages, plus the tabs themselves (they render a signed-out
/// state). Gated: onboarding, manage, claim, name edit. The original target
/// is carried through `from=` so a poster QR that leads to sign-in still
/// lands on the pledge afterwards.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Where sign-in gates *doing*, not looking.
  ///
  /// Public: welcome, sign-in, discover, drive, organisation, pledge and
  /// certificate pages, plus the tabs themselves (they render a signed-out
  /// state). Gated: onboarding, manage, claim, name edit. The original target
  /// is carried through `from=` so a poster QR that leads to sign-in still
  /// lands on the pledge afterwards.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'1ce0d173d4847c5cab3021e04748ea0ad56b9d3a';
