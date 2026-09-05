// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snapshots.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Overridden in main() with the real instance.

@ProviderFor(snapshots)
final snapshotsProvider = SnapshotsProvider._();

/// Overridden in main() with the real instance.

final class SnapshotsProvider
    extends $FunctionalProvider<Snapshots, Snapshots, Snapshots>
    with $Provider<Snapshots> {
  /// Overridden in main() with the real instance.
  SnapshotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snapshotsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snapshotsHash();

  @$internal
  @override
  $ProviderElement<Snapshots> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Snapshots create(Ref ref) {
    return snapshots(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Snapshots value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Snapshots>(value),
    );
  }
}

String _$snapshotsHash() => r'838639e0e88e922ded0d9050b5c98849ed9be7d7';
