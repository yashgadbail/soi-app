// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(welcomeStats)
final welcomeStatsProvider = WelcomeStatsProvider._();

final class WelcomeStatsProvider
    extends $FunctionalProvider<AsyncValue<Stats>, Stats, FutureOr<Stats>>
    with $FutureModifier<Stats>, $FutureProvider<Stats> {
  WelcomeStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'welcomeStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$welcomeStatsHash();

  @$internal
  @override
  $FutureProviderElement<Stats> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Stats> create(Ref ref) {
    return welcomeStats(ref);
  }
}

String _$welcomeStatsHash() => r'b5e4663f40bffbdbf190f02b847350eae353f340';

@ProviderFor(welcomeDrives)
final welcomeDrivesProvider = WelcomeDrivesProvider._();

final class WelcomeDrivesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DriveSummary>>,
          List<DriveSummary>,
          FutureOr<List<DriveSummary>>
        >
    with
        $FutureModifier<List<DriveSummary>>,
        $FutureProvider<List<DriveSummary>> {
  WelcomeDrivesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'welcomeDrivesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$welcomeDrivesHash();

  @$internal
  @override
  $FutureProviderElement<List<DriveSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DriveSummary>> create(Ref ref) {
    return welcomeDrives(ref);
  }
}

String _$welcomeDrivesHash() => r'9c61f786d02ef00fa8b0ba913c2043b7c65312d1';
