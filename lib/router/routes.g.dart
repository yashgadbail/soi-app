// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $welcomeRoute,
  $signInRoute,
  $onboardingNameRoute,
  $onboardingIntentRoute,
  $homeShellRoute,
  $driveRoute,
  $orgRoute,
  $pledgeRoute,
  $certificateRoute,
  $claimRoute,
  $nameEditRoute,
  $orgNewRoute,
  $orgSettingsRoute,
  $orgEditRoute,
  $rosterRoute,
  $orgPledgesRoute,
  $pledgeNewRoute,
  $pledgeEditRoute,
  $driveNewRoute,
  $driveEditRoute,
  $coordinatorRoute,
  $markRoute,
];

RouteBase get $welcomeRoute => GoRouteData.$route(
  path: '/welcome',
  hasOverriddenOnExit: false,
  factory: $WelcomeRoute._fromState,
);

mixin $WelcomeRoute on GoRouteData {
  static WelcomeRoute _fromState(GoRouterState state) => const WelcomeRoute();

  @override
  String get location => GoRouteData.$location('/welcome');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInRoute => GoRouteData.$route(
  path: '/sign-in',
  hasOverriddenOnExit: false,
  factory: $SignInRoute._fromState,
);

mixin $SignInRoute on GoRouteData {
  static SignInRoute _fromState(GoRouterState state) =>
      SignInRoute(from: state.uri.queryParameters['from']);

  SignInRoute get _self => this as SignInRoute;

  @override
  String get location => GoRouteData.$location(
    '/sign-in',
    queryParams: {if (_self.from != null) 'from': _self.from},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingNameRoute => GoRouteData.$route(
  path: '/onboarding/name',
  hasOverriddenOnExit: false,
  factory: $OnboardingNameRoute._fromState,
);

mixin $OnboardingNameRoute on GoRouteData {
  static OnboardingNameRoute _fromState(GoRouterState state) =>
      OnboardingNameRoute(from: state.uri.queryParameters['from']);

  OnboardingNameRoute get _self => this as OnboardingNameRoute;

  @override
  String get location => GoRouteData.$location(
    '/onboarding/name',
    queryParams: {if (_self.from != null) 'from': _self.from},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingIntentRoute => GoRouteData.$route(
  path: '/onboarding/intent',
  hasOverriddenOnExit: false,
  factory: $OnboardingIntentRoute._fromState,
);

mixin $OnboardingIntentRoute on GoRouteData {
  static OnboardingIntentRoute _fromState(GoRouterState state) =>
      OnboardingIntentRoute(from: state.uri.queryParameters['from']);

  OnboardingIntentRoute get _self => this as OnboardingIntentRoute;

  @override
  String get location => GoRouteData.$location(
    '/onboarding/intent',
    queryParams: {if (_self.from != null) 'from': _self.from},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeShellRoute => StatefulShellRouteData.$route(
  factory: $HomeShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/discover',
          hasOverriddenOnExit: false,
          factory: $DiscoverRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/check-in',
          hasOverriddenOnExit: false,
          factory: $CheckInRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/passport',
          hasOverriddenOnExit: false,
          factory: $PassportRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/profile',
          hasOverriddenOnExit: false,
          factory: $ProfileRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/manage',
          hasOverriddenOnExit: false,
          factory: $ManageRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

mixin $DiscoverRoute on GoRouteData {
  static DiscoverRoute _fromState(GoRouterState state) => const DiscoverRoute();

  @override
  String get location => GoRouteData.$location('/discover');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CheckInRoute on GoRouteData {
  static CheckInRoute _fromState(GoRouterState state) => const CheckInRoute();

  @override
  String get location => GoRouteData.$location('/check-in');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PassportRoute on GoRouteData {
  static PassportRoute _fromState(GoRouterState state) => const PassportRoute();

  @override
  String get location => GoRouteData.$location('/passport');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ManageRoute on GoRouteData {
  static ManageRoute _fromState(GoRouterState state) => const ManageRoute();

  @override
  String get location => GoRouteData.$location('/manage');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $driveRoute => GoRouteData.$route(
  path: '/drive/:id',
  hasOverriddenOnExit: false,
  parentNavigatorKey: DriveRoute.$parentNavigatorKey,
  factory: $DriveRoute._fromState,
);

mixin $DriveRoute on GoRouteData {
  static DriveRoute _fromState(GoRouterState state) =>
      DriveRoute(id: state.pathParameters['id']!);

  DriveRoute get _self => this as DriveRoute;

  @override
  String get location =>
      GoRouteData.$location('/drive/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $orgRoute => GoRouteData.$route(
  path: '/org/:id',
  hasOverriddenOnExit: false,
  parentNavigatorKey: OrgRoute.$parentNavigatorKey,
  factory: $OrgRoute._fromState,
);

mixin $OrgRoute on GoRouteData {
  static OrgRoute _fromState(GoRouterState state) =>
      OrgRoute(id: state.pathParameters['id']!);

  OrgRoute get _self => this as OrgRoute;

  @override
  String get location =>
      GoRouteData.$location('/org/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pledgeRoute => GoRouteData.$route(
  path: '/pledge/:code',
  hasOverriddenOnExit: false,
  parentNavigatorKey: PledgeRoute.$parentNavigatorKey,
  factory: $PledgeRoute._fromState,
);

mixin $PledgeRoute on GoRouteData {
  static PledgeRoute _fromState(GoRouterState state) =>
      PledgeRoute(code: state.pathParameters['code']!);

  PledgeRoute get _self => this as PledgeRoute;

  @override
  String get location =>
      GoRouteData.$location('/pledge/${Uri.encodeComponent(_self.code)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $certificateRoute => GoRouteData.$route(
  path: '/certificate/:code',
  hasOverriddenOnExit: false,
  parentNavigatorKey: CertificateRoute.$parentNavigatorKey,
  factory: $CertificateRoute._fromState,
);

mixin $CertificateRoute on GoRouteData {
  static CertificateRoute _fromState(GoRouterState state) =>
      CertificateRoute(code: state.pathParameters['code']!);

  CertificateRoute get _self => this as CertificateRoute;

  @override
  String get location =>
      GoRouteData.$location('/certificate/${Uri.encodeComponent(_self.code)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $claimRoute => GoRouteData.$route(
  path: '/claim',
  hasOverriddenOnExit: false,
  parentNavigatorKey: ClaimRoute.$parentNavigatorKey,
  factory: $ClaimRoute._fromState,
);

mixin $ClaimRoute on GoRouteData {
  static ClaimRoute _fromState(GoRouterState state) => const ClaimRoute();

  @override
  String get location => GoRouteData.$location('/claim');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $nameEditRoute => GoRouteData.$route(
  path: '/profile/name',
  hasOverriddenOnExit: false,
  parentNavigatorKey: NameEditRoute.$parentNavigatorKey,
  factory: $NameEditRoute._fromState,
);

mixin $NameEditRoute on GoRouteData {
  static NameEditRoute _fromState(GoRouterState state) => const NameEditRoute();

  @override
  String get location => GoRouteData.$location('/profile/name');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $orgNewRoute => GoRouteData.$route(
  path: '/manage/org/new',
  hasOverriddenOnExit: false,
  parentNavigatorKey: OrgNewRoute.$parentNavigatorKey,
  factory: $OrgNewRoute._fromState,
);

mixin $OrgNewRoute on GoRouteData {
  static OrgNewRoute _fromState(GoRouterState state) => const OrgNewRoute();

  @override
  String get location => GoRouteData.$location('/manage/org/new');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $orgSettingsRoute => GoRouteData.$route(
  path: '/manage/org/:id',
  hasOverriddenOnExit: false,
  parentNavigatorKey: OrgSettingsRoute.$parentNavigatorKey,
  factory: $OrgSettingsRoute._fromState,
);

mixin $OrgSettingsRoute on GoRouteData {
  static OrgSettingsRoute _fromState(GoRouterState state) =>
      OrgSettingsRoute(id: state.pathParameters['id']!);

  OrgSettingsRoute get _self => this as OrgSettingsRoute;

  @override
  String get location =>
      GoRouteData.$location('/manage/org/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $orgEditRoute => GoRouteData.$route(
  path: '/manage/org/:id/edit',
  hasOverriddenOnExit: false,
  parentNavigatorKey: OrgEditRoute.$parentNavigatorKey,
  factory: $OrgEditRoute._fromState,
);

mixin $OrgEditRoute on GoRouteData {
  static OrgEditRoute _fromState(GoRouterState state) =>
      OrgEditRoute(id: state.pathParameters['id']!);

  OrgEditRoute get _self => this as OrgEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/org/${Uri.encodeComponent(_self.id)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rosterRoute => GoRouteData.$route(
  path: '/manage/org/:id/roster',
  hasOverriddenOnExit: false,
  parentNavigatorKey: RosterRoute.$parentNavigatorKey,
  factory: $RosterRoute._fromState,
);

mixin $RosterRoute on GoRouteData {
  static RosterRoute _fromState(GoRouterState state) =>
      RosterRoute(id: state.pathParameters['id']!);

  RosterRoute get _self => this as RosterRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/org/${Uri.encodeComponent(_self.id)}/roster',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $orgPledgesRoute => GoRouteData.$route(
  path: '/manage/org/:id/pledges',
  hasOverriddenOnExit: false,
  parentNavigatorKey: OrgPledgesRoute.$parentNavigatorKey,
  factory: $OrgPledgesRoute._fromState,
);

mixin $OrgPledgesRoute on GoRouteData {
  static OrgPledgesRoute _fromState(GoRouterState state) =>
      OrgPledgesRoute(id: state.pathParameters['id']!);

  OrgPledgesRoute get _self => this as OrgPledgesRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/org/${Uri.encodeComponent(_self.id)}/pledges',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pledgeNewRoute => GoRouteData.$route(
  path: '/manage/org/:id/pledge/new',
  hasOverriddenOnExit: false,
  parentNavigatorKey: PledgeNewRoute.$parentNavigatorKey,
  factory: $PledgeNewRoute._fromState,
);

mixin $PledgeNewRoute on GoRouteData {
  static PledgeNewRoute _fromState(GoRouterState state) =>
      PledgeNewRoute(id: state.pathParameters['id']!);

  PledgeNewRoute get _self => this as PledgeNewRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/org/${Uri.encodeComponent(_self.id)}/pledge/new',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pledgeEditRoute => GoRouteData.$route(
  path: '/manage/pledge/:code/edit',
  hasOverriddenOnExit: false,
  parentNavigatorKey: PledgeEditRoute.$parentNavigatorKey,
  factory: $PledgeEditRoute._fromState,
);

mixin $PledgeEditRoute on GoRouteData {
  static PledgeEditRoute _fromState(GoRouterState state) =>
      PledgeEditRoute(code: state.pathParameters['code']!);

  PledgeEditRoute get _self => this as PledgeEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/pledge/${Uri.encodeComponent(_self.code)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $driveNewRoute => GoRouteData.$route(
  path: '/manage/drive/new',
  hasOverriddenOnExit: false,
  parentNavigatorKey: DriveNewRoute.$parentNavigatorKey,
  factory: $DriveNewRoute._fromState,
);

mixin $DriveNewRoute on GoRouteData {
  static DriveNewRoute _fromState(GoRouterState state) =>
      DriveNewRoute(org: state.uri.queryParameters['org']);

  DriveNewRoute get _self => this as DriveNewRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/drive/new',
    queryParams: {if (_self.org != null) 'org': _self.org},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $driveEditRoute => GoRouteData.$route(
  path: '/manage/drive/:id/edit',
  hasOverriddenOnExit: false,
  parentNavigatorKey: DriveEditRoute.$parentNavigatorKey,
  factory: $DriveEditRoute._fromState,
);

mixin $DriveEditRoute on GoRouteData {
  static DriveEditRoute _fromState(GoRouterState state) =>
      DriveEditRoute(id: state.pathParameters['id']!);

  DriveEditRoute get _self => this as DriveEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/drive/${Uri.encodeComponent(_self.id)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $coordinatorRoute => GoRouteData.$route(
  path: '/manage/drive/:id/mode',
  hasOverriddenOnExit: false,
  parentNavigatorKey: CoordinatorRoute.$parentNavigatorKey,
  factory: $CoordinatorRoute._fromState,
);

mixin $CoordinatorRoute on GoRouteData {
  static CoordinatorRoute _fromState(GoRouterState state) =>
      CoordinatorRoute(id: state.pathParameters['id']!);

  CoordinatorRoute get _self => this as CoordinatorRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/drive/${Uri.encodeComponent(_self.id)}/mode',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $markRoute => GoRouteData.$route(
  path: '/manage/drive/:id/mark',
  hasOverriddenOnExit: false,
  parentNavigatorKey: MarkRoute.$parentNavigatorKey,
  factory: $MarkRoute._fromState,
);

mixin $MarkRoute on GoRouteData {
  static MarkRoute _fromState(GoRouterState state) =>
      MarkRoute(id: state.pathParameters['id']!);

  MarkRoute get _self => this as MarkRoute;

  @override
  String get location => GoRouteData.$location(
    '/manage/drive/${Uri.encodeComponent(_self.id)}/mark',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
