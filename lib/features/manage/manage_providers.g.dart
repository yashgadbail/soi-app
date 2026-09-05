// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which organisation the Manage tab is acting for. Defaults to the first
/// organisation the user coordinates; persists across screens.

@ProviderFor(SelectedOrg)
final selectedOrgProvider = SelectedOrgProvider._();

/// Which organisation the Manage tab is acting for. Defaults to the first
/// organisation the user coordinates; persists across screens.
final class SelectedOrgProvider
    extends $NotifierProvider<SelectedOrg, String?> {
  /// Which organisation the Manage tab is acting for. Defaults to the first
  /// organisation the user coordinates; persists across screens.
  SelectedOrgProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedOrgProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedOrgHash();

  @$internal
  @override
  SelectedOrg create() => SelectedOrg();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedOrgHash() => r'75db492c1c9c873c8ebbb54416abb68ee9ba1115';

/// Which organisation the Manage tab is acting for. Defaults to the first
/// organisation the user coordinates; persists across screens.

abstract class _$SelectedOrg extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The effective organisation for coordinator screens (selected or first).

@ProviderFor(currentOrg)
final currentOrgProvider = CurrentOrgProvider._();

/// The effective organisation for coordinator screens (selected or first).

final class CurrentOrgProvider
    extends $FunctionalProvider<Membership?, Membership?, Membership?>
    with $Provider<Membership?> {
  /// The effective organisation for coordinator screens (selected or first).
  CurrentOrgProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentOrgProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentOrgHash();

  @$internal
  @override
  $ProviderElement<Membership?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Membership? create(Ref ref) {
    return currentOrg(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Membership? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Membership?>(value),
    );
  }
}

String _$currentOrgHash() => r'69cd5bbc7f0742838843a20f519b28d7eebccc88';

@ProviderFor(orgDrives)
final orgDrivesProvider = OrgDrivesFamily._();

final class OrgDrivesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrgDrive>>,
          List<OrgDrive>,
          FutureOr<List<OrgDrive>>
        >
    with $FutureModifier<List<OrgDrive>>, $FutureProvider<List<OrgDrive>> {
  OrgDrivesProvider._({
    required OrgDrivesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orgDrivesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orgDrivesHash();

  @override
  String toString() {
    return r'orgDrivesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<OrgDrive>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrgDrive>> create(Ref ref) {
    final argument = this.argument as String;
    return orgDrives(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrgDrivesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orgDrivesHash() => r'89eac650121ebaf814addebbee34b1d2e935556d';

final class OrgDrivesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<OrgDrive>>, String> {
  OrgDrivesFamily._()
    : super(
        retry: null,
        name: r'orgDrivesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrgDrivesProvider call(String orgId) =>
      OrgDrivesProvider._(argument: orgId, from: this);

  @override
  String toString() => r'orgDrivesProvider';
}

@ProviderFor(orgRoster)
final orgRosterProvider = OrgRosterFamily._();

final class OrgRosterProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Student>>,
          List<Student>,
          FutureOr<List<Student>>
        >
    with $FutureModifier<List<Student>>, $FutureProvider<List<Student>> {
  OrgRosterProvider._({
    required OrgRosterFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orgRosterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orgRosterHash();

  @override
  String toString() {
    return r'orgRosterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Student>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Student>> create(Ref ref) {
    final argument = this.argument as String;
    return orgRoster(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrgRosterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orgRosterHash() => r'50f2ef03301da4770633189223dfbaddef381eda';

final class OrgRosterFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Student>>, String> {
  OrgRosterFamily._()
    : super(
        retry: null,
        name: r'orgRosterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrgRosterProvider call(String orgId) =>
      OrgRosterProvider._(argument: orgId, from: this);

  @override
  String toString() => r'orgRosterProvider';
}

@ProviderFor(orgPledges)
final orgPledgesProvider = OrgPledgesFamily._();

final class OrgPledgesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrgPledge>>,
          List<OrgPledge>,
          FutureOr<List<OrgPledge>>
        >
    with $FutureModifier<List<OrgPledge>>, $FutureProvider<List<OrgPledge>> {
  OrgPledgesProvider._({
    required OrgPledgesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orgPledgesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orgPledgesHash();

  @override
  String toString() {
    return r'orgPledgesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<OrgPledge>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrgPledge>> create(Ref ref) {
    final argument = this.argument as String;
    return orgPledges(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrgPledgesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orgPledgesHash() => r'6dab9ae3c6b66fb229d603dcd73ad5dc35e75a70';

final class OrgPledgesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<OrgPledge>>, String> {
  OrgPledgesFamily._()
    : super(
        retry: null,
        name: r'orgPledgesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrgPledgesProvider call(String orgId) =>
      OrgPledgesProvider._(argument: orgId, from: this);

  @override
  String toString() => r'orgPledgesProvider';
}

@ProviderFor(orgMembers)
final orgMembersProvider = OrgMembersFamily._();

final class OrgMembersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrgMember>>,
          List<OrgMember>,
          FutureOr<List<OrgMember>>
        >
    with $FutureModifier<List<OrgMember>>, $FutureProvider<List<OrgMember>> {
  OrgMembersProvider._({
    required OrgMembersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orgMembersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orgMembersHash();

  @override
  String toString() {
    return r'orgMembersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<OrgMember>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrgMember>> create(Ref ref) {
    final argument = this.argument as String;
    return orgMembers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrgMembersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orgMembersHash() => r'bbede0d614e3c95fd8ffb499d24adfbcee39af13';

final class OrgMembersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<OrgMember>>, String> {
  OrgMembersFamily._()
    : super(
        retry: null,
        name: r'orgMembersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrgMembersProvider call(String orgId) =>
      OrgMembersProvider._(argument: orgId, from: this);

  @override
  String toString() => r'orgMembersProvider';
}

@ProviderFor(orgInvites)
final orgInvitesProvider = OrgInvitesFamily._();

final class OrgInvitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrgInvite>>,
          List<OrgInvite>,
          FutureOr<List<OrgInvite>>
        >
    with $FutureModifier<List<OrgInvite>>, $FutureProvider<List<OrgInvite>> {
  OrgInvitesProvider._({
    required OrgInvitesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orgInvitesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orgInvitesHash();

  @override
  String toString() {
    return r'orgInvitesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<OrgInvite>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrgInvite>> create(Ref ref) {
    final argument = this.argument as String;
    return orgInvites(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrgInvitesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orgInvitesHash() => r'4e7342dc0f7a8171957fb9afd1fdd85a103cdf18';

final class OrgInvitesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<OrgInvite>>, String> {
  OrgInvitesFamily._()
    : super(
        retry: null,
        name: r'orgInvitesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrgInvitesProvider call(String orgId) =>
      OrgInvitesProvider._(argument: orgId, from: this);

  @override
  String toString() => r'orgInvitesProvider';
}
