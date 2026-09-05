import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soi/features/auth/sign_in_screen.dart';
import 'package:soi/features/certificate/certificate_screen.dart';
import 'package:soi/features/checkin/check_in_screen.dart';
import 'package:soi/features/discover/discover_screen.dart';
import 'package:soi/features/drive/drive_screen.dart';
import 'package:soi/features/manage/coordinator_mode_screen.dart';
import 'package:soi/features/manage/drive_form_screen.dart';
import 'package:soi/features/manage/manage_screen.dart';
import 'package:soi/features/manage/mark_attendance_screen.dart';
import 'package:soi/features/manage/org_form_screen.dart';
import 'package:soi/features/manage/org_pledges_screen.dart';
import 'package:soi/features/manage/org_settings_screen.dart';
import 'package:soi/features/manage/pledge_form_screen.dart';
import 'package:soi/features/manage/roster_screen.dart';
import 'package:soi/features/onboarding/intent_screen.dart';
import 'package:soi/features/onboarding/name_screen.dart';
import 'package:soi/features/org/org_screen.dart';
import 'package:soi/features/passport/passport_screen.dart';
import 'package:soi/features/pledge/pledge_screen.dart';
import 'package:soi/features/profile/claim_screen.dart';
import 'package:soi/features/profile/name_edit_screen.dart';
import 'package:soi/features/profile/profile_screen.dart';
import 'package:soi/features/shell/home_shell.dart';
import 'package:soi/features/welcome/welcome_screen.dart';

part 'routes.g.dart';

/// Typed routes. Every navigation in the app goes through one of these
/// classes, so a renamed path or a missing parameter is a compile error.
///
/// Detail pages live on the root navigator (no bottom bar) so a drive opened
/// from a QR, a share link or any tab looks the same.

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

// ------------------------------------------------------------ public / auth

@TypedGoRoute<WelcomeRoute>(path: '/welcome')
class WelcomeRoute extends GoRouteData with $WelcomeRoute {
  const WelcomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const WelcomeScreen();
}

@TypedGoRoute<SignInRoute>(path: '/sign-in')
class SignInRoute extends GoRouteData with $SignInRoute {
  const SignInRoute({this.from});
  final String? from;
  @override
  Widget build(BuildContext context, GoRouterState state) => SignInScreen(from: from);
}

@TypedGoRoute<OnboardingNameRoute>(path: '/onboarding/name')
class OnboardingNameRoute extends GoRouteData with $OnboardingNameRoute {
  const OnboardingNameRoute({this.from});
  final String? from;
  @override
  Widget build(BuildContext context, GoRouterState state) => OnboardingNameScreen(from: from);
}

@TypedGoRoute<OnboardingIntentRoute>(path: '/onboarding/intent')
class OnboardingIntentRoute extends GoRouteData with $OnboardingIntentRoute {
  const OnboardingIntentRoute({this.from});
  final String? from;
  @override
  Widget build(BuildContext context, GoRouterState state) => OnboardingIntentScreen(from: from);
}

// ------------------------------------------------------------ shell (tabs)

@TypedStatefulShellRoute<HomeShellRoute>(
  branches: [
    TypedStatefulShellBranch<DiscoverBranch>(routes: [TypedGoRoute<DiscoverRoute>(path: '/discover')]),
    TypedStatefulShellBranch<CheckInBranch>(routes: [TypedGoRoute<CheckInRoute>(path: '/check-in')]),
    TypedStatefulShellBranch<PassportBranch>(routes: [TypedGoRoute<PassportRoute>(path: '/passport')]),
    TypedStatefulShellBranch<ProfileBranch>(routes: [TypedGoRoute<ProfileRoute>(path: '/profile')]),
    TypedStatefulShellBranch<ManageBranch>(routes: [TypedGoRoute<ManageRoute>(path: '/manage')]),
  ],
)
class HomeShellRoute extends StatefulShellRouteData {
  const HomeShellRoute();
  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;
  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) =>
      HomeShell(shell: navigationShell);
}

class DiscoverBranch extends StatefulShellBranchData {
  const DiscoverBranch();
}

class CheckInBranch extends StatefulShellBranchData {
  const CheckInBranch();
}

class PassportBranch extends StatefulShellBranchData {
  const PassportBranch();
}

class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();
}

class ManageBranch extends StatefulShellBranchData {
  const ManageBranch();
}

class DiscoverRoute extends GoRouteData with $DiscoverRoute {
  const DiscoverRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const DiscoverScreen();
}

class CheckInRoute extends GoRouteData with $CheckInRoute {
  const CheckInRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const CheckInScreen();
}

class PassportRoute extends GoRouteData with $PassportRoute {
  const PassportRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const PassportScreen();
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfileScreen();
}

class ManageRoute extends GoRouteData with $ManageRoute {
  const ManageRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ManageScreen();
}

// ------------------------------------------------------------ detail (root)

@TypedGoRoute<DriveRoute>(path: '/drive/:id')
class DriveRoute extends GoRouteData with $DriveRoute {
  const DriveRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => DriveScreen(id: id);
}

@TypedGoRoute<OrgRoute>(path: '/org/:id')
class OrgRoute extends GoRouteData with $OrgRoute {
  const OrgRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => OrgScreen(id: id);
}

@TypedGoRoute<PledgeRoute>(path: '/pledge/:code')
class PledgeRoute extends GoRouteData with $PledgeRoute {
  const PledgeRoute({required this.code});
  final String code;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => PledgeScreen(code: code);
}

@TypedGoRoute<CertificateRoute>(path: '/certificate/:code')
class CertificateRoute extends GoRouteData with $CertificateRoute {
  const CertificateRoute({required this.code});
  final String code;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => CertificateScreen(code: code);
}

@TypedGoRoute<ClaimRoute>(path: '/claim')
class ClaimRoute extends GoRouteData with $ClaimRoute {
  const ClaimRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const ClaimScreen();
}

@TypedGoRoute<NameEditRoute>(path: '/profile/name')
class NameEditRoute extends GoRouteData with $NameEditRoute {
  const NameEditRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const NameEditScreen();
}

// ------------------------------------------------------------ manage (root)

@TypedGoRoute<OrgNewRoute>(path: '/manage/org/new')
class OrgNewRoute extends GoRouteData with $OrgNewRoute {
  const OrgNewRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const OrgFormScreen();
}

@TypedGoRoute<OrgSettingsRoute>(path: '/manage/org/:id')
class OrgSettingsRoute extends GoRouteData with $OrgSettingsRoute {
  const OrgSettingsRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => OrgSettingsScreen(orgId: id);
}

@TypedGoRoute<OrgEditRoute>(path: '/manage/org/:id/edit')
class OrgEditRoute extends GoRouteData with $OrgEditRoute {
  const OrgEditRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => OrgFormScreen(orgId: id);
}

@TypedGoRoute<RosterRoute>(path: '/manage/org/:id/roster')
class RosterRoute extends GoRouteData with $RosterRoute {
  const RosterRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => RosterScreen(orgId: id);
}

@TypedGoRoute<OrgPledgesRoute>(path: '/manage/org/:id/pledges')
class OrgPledgesRoute extends GoRouteData with $OrgPledgesRoute {
  const OrgPledgesRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => OrgPledgesScreen(orgId: id);
}

@TypedGoRoute<PledgeNewRoute>(path: '/manage/org/:id/pledge/new')
class PledgeNewRoute extends GoRouteData with $PledgeNewRoute {
  const PledgeNewRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => PledgeFormScreen(orgId: id);
}

@TypedGoRoute<PledgeEditRoute>(path: '/manage/pledge/:code/edit')
class PledgeEditRoute extends GoRouteData with $PledgeEditRoute {
  const PledgeEditRoute({required this.code});
  final String code;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => PledgeFormScreen(shareCode: code);
}

@TypedGoRoute<DriveNewRoute>(path: '/manage/drive/new')
class DriveNewRoute extends GoRouteData with $DriveNewRoute {
  const DriveNewRoute({this.org});
  final String? org;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => DriveFormScreen(orgId: org);
}

@TypedGoRoute<DriveEditRoute>(path: '/manage/drive/:id/edit')
class DriveEditRoute extends GoRouteData with $DriveEditRoute {
  const DriveEditRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => DriveFormScreen(driveId: id);
}

@TypedGoRoute<CoordinatorRoute>(path: '/manage/drive/:id/mode')
class CoordinatorRoute extends GoRouteData with $CoordinatorRoute {
  const CoordinatorRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => CoordinatorModeScreen(driveId: id);
}

@TypedGoRoute<MarkRoute>(path: '/manage/drive/:id/mark')
class MarkRoute extends GoRouteData with $MarkRoute {
  const MarkRoute({required this.id});
  final String id;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => MarkAttendanceScreen(driveId: id);
}
