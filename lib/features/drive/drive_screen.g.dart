// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drive_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driveDetail)
final driveDetailProvider = DriveDetailFamily._();

final class DriveDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<DriveDetail>,
          DriveDetail,
          FutureOr<DriveDetail>
        >
    with $FutureModifier<DriveDetail>, $FutureProvider<DriveDetail> {
  DriveDetailProvider._({
    required DriveDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'driveDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driveDetailHash();

  @override
  String toString() {
    return r'driveDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<DriveDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DriveDetail> create(Ref ref) {
    final argument = this.argument as String;
    return driveDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DriveDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driveDetailHash() => r'ab6d7697d1953999741082adee3d3001dcc78b09';

final class DriveDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<DriveDetail>, String> {
  DriveDetailFamily._()
    : super(
        retry: null,
        name: r'driveDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DriveDetailProvider call(String id) =>
      DriveDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'driveDetailProvider';
}
