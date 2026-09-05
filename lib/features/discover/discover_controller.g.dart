// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Search + filters + pagination for the Discover tab.
///
/// The first page is cached on device so a cold start paints instantly;
/// the network result replaces it. Every request carries a generation
/// number so a slow response from an old filter can never overwrite a
/// newer one.

@ProviderFor(DiscoverController)
final discoverControllerProvider = DiscoverControllerProvider._();

/// Search + filters + pagination for the Discover tab.
///
/// The first page is cached on device so a cold start paints instantly;
/// the network result replaces it. Every request carries a generation
/// number so a slow response from an old filter can never overwrite a
/// newer one.
final class DiscoverControllerProvider
    extends $NotifierProvider<DiscoverController, DiscoverState> {
  /// Search + filters + pagination for the Discover tab.
  ///
  /// The first page is cached on device so a cold start paints instantly;
  /// the network result replaces it. Every request carries a generation
  /// number so a slow response from an old filter can never overwrite a
  /// newer one.
  DiscoverControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverControllerHash();

  @$internal
  @override
  DiscoverController create() => DiscoverController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscoverState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscoverState>(value),
    );
  }
}

String _$discoverControllerHash() =>
    r'137a889ce20b0785e48f67568313ec23e89ca0ae';

/// Search + filters + pagination for the Discover tab.
///
/// The first page is cached on device so a cold start paints instantly;
/// the network result replaces it. Every request carries a generation
/// number so a slow response from an old filter can never overwrite a
/// newer one.

abstract class _$DiscoverController extends $Notifier<DiscoverState> {
  DiscoverState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DiscoverState, DiscoverState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DiscoverState, DiscoverState>,
              DiscoverState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(discoverFacets)
final discoverFacetsProvider = DiscoverFacetsProvider._();

final class DiscoverFacetsProvider
    extends $FunctionalProvider<AsyncValue<Facets>, Facets, FutureOr<Facets>>
    with $FutureModifier<Facets>, $FutureProvider<Facets> {
  DiscoverFacetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverFacetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverFacetsHash();

  @$internal
  @override
  $FutureProviderElement<Facets> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Facets> create(Ref ref) {
    return discoverFacets(ref);
  }
}

String _$discoverFacetsHash() => r'b8e143babd5df819d3d4a123d0fb3a525171bb68';
