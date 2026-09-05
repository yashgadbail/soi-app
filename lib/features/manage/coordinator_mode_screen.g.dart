// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinator_mode_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkinCode)
final checkinCodeProvider = CheckinCodeFamily._();

final class CheckinCodeProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  CheckinCodeProvider._({
    required CheckinCodeFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'checkinCodeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$checkinCodeHash();

  @override
  String toString() {
    return r'checkinCodeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return checkinCode(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckinCodeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$checkinCodeHash() => r'8859d52186ab2ce913909221f796f78b0b3b90cd';

final class CheckinCodeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  CheckinCodeFamily._()
    : super(
        retry: null,
        name: r'checkinCodeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CheckinCodeProvider call(String driveId) =>
      CheckinCodeProvider._(argument: driveId, from: this);

  @override
  String toString() => r'checkinCodeProvider';
}

/// Live roster for one drive.
///
/// Realtime payloads carry attendance columns only (no names), so:
///   UPDATE  -> patch status/certified_at in place, no fetch
///   INSERT  -> coalesce for 300 ms, then one roster() fetch
///   DELETE  -> drop the row
///   (re)subscribed -> full fetch, in case events were missed
/// Everything is idempotent by row id because our own certify response
/// races the realtime event.

@ProviderFor(DriveRoster)
final driveRosterProvider = DriveRosterFamily._();

/// Live roster for one drive.
///
/// Realtime payloads carry attendance columns only (no names), so:
///   UPDATE  -> patch status/certified_at in place, no fetch
///   INSERT  -> coalesce for 300 ms, then one roster() fetch
///   DELETE  -> drop the row
///   (re)subscribed -> full fetch, in case events were missed
/// Everything is idempotent by row id because our own certify response
/// races the realtime event.
final class DriveRosterProvider
    extends $AsyncNotifierProvider<DriveRoster, List<RosterRow>> {
  /// Live roster for one drive.
  ///
  /// Realtime payloads carry attendance columns only (no names), so:
  ///   UPDATE  -> patch status/certified_at in place, no fetch
  ///   INSERT  -> coalesce for 300 ms, then one roster() fetch
  ///   DELETE  -> drop the row
  ///   (re)subscribed -> full fetch, in case events were missed
  /// Everything is idempotent by row id because our own certify response
  /// races the realtime event.
  DriveRosterProvider._({
    required DriveRosterFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'driveRosterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driveRosterHash();

  @override
  String toString() {
    return r'driveRosterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DriveRoster create() => DriveRoster();

  @override
  bool operator ==(Object other) {
    return other is DriveRosterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driveRosterHash() => r'097e489705bec87fcbe61c8e5d1a86ce94bf492c';

/// Live roster for one drive.
///
/// Realtime payloads carry attendance columns only (no names), so:
///   UPDATE  -> patch status/certified_at in place, no fetch
///   INSERT  -> coalesce for 300 ms, then one roster() fetch
///   DELETE  -> drop the row
///   (re)subscribed -> full fetch, in case events were missed
/// Everything is idempotent by row id because our own certify response
/// races the realtime event.

final class DriveRosterFamily extends $Family
    with
        $ClassFamilyOverride<
          DriveRoster,
          AsyncValue<List<RosterRow>>,
          List<RosterRow>,
          FutureOr<List<RosterRow>>,
          String
        > {
  DriveRosterFamily._()
    : super(
        retry: null,
        name: r'driveRosterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Live roster for one drive.
  ///
  /// Realtime payloads carry attendance columns only (no names), so:
  ///   UPDATE  -> patch status/certified_at in place, no fetch
  ///   INSERT  -> coalesce for 300 ms, then one roster() fetch
  ///   DELETE  -> drop the row
  ///   (re)subscribed -> full fetch, in case events were missed
  /// Everything is idempotent by row id because our own certify response
  /// races the realtime event.

  DriveRosterProvider call(String driveId) =>
      DriveRosterProvider._(argument: driveId, from: this);

  @override
  String toString() => r'driveRosterProvider';
}

/// Live roster for one drive.
///
/// Realtime payloads carry attendance columns only (no names), so:
///   UPDATE  -> patch status/certified_at in place, no fetch
///   INSERT  -> coalesce for 300 ms, then one roster() fetch
///   DELETE  -> drop the row
///   (re)subscribed -> full fetch, in case events were missed
/// Everything is idempotent by row id because our own certify response
/// races the realtime event.

abstract class _$DriveRoster extends $AsyncNotifier<List<RosterRow>> {
  late final _$args = ref.$arg as String;
  String get driveId => _$args;

  FutureOr<List<RosterRow>> build(String driveId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<RosterRow>>, List<RosterRow>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RosterRow>>, List<RosterRow>>,
              AsyncValue<List<RosterRow>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
