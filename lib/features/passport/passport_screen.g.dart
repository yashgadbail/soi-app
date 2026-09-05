// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(passport)
final passportProvider = PassportProvider._();

final class PassportProvider
    extends
        $FunctionalProvider<AsyncValue<Passport>, Passport, FutureOr<Passport>>
    with $FutureModifier<Passport>, $FutureProvider<Passport> {
  PassportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passportHash();

  @$internal
  @override
  $FutureProviderElement<Passport> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Passport> create(Ref ref) {
    return passport(ref);
  }
}

String _$passportHash() => r'425c214b698067259588655f2026f2b7e0077e35';

@ProviderFor(myUpcoming)
final myUpcomingProvider = MyUpcomingProvider._();

final class MyUpcomingProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UpcomingDrive>>,
          List<UpcomingDrive>,
          FutureOr<List<UpcomingDrive>>
        >
    with
        $FutureModifier<List<UpcomingDrive>>,
        $FutureProvider<List<UpcomingDrive>> {
  MyUpcomingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myUpcomingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myUpcomingHash();

  @$internal
  @override
  $FutureProviderElement<List<UpcomingDrive>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UpcomingDrive>> create(Ref ref) {
    return myUpcoming(ref);
  }
}

String _$myUpcomingHash() => r'8a19ff409c54ad6b81c18701db7cba851af340dd';
