import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/snapshots.dart';

part 'discover_controller.g.dart';

@immutable
class DiscoverState {
  const DiscoverState({
    this.query = '',
    this.cause,
    this.city,
    this.sort = 'soonest',
    this.rows = const [],
    this.loading = true,
    this.loadingMore = false,
    this.endReached = false,
    this.error,
    this.fromSnapshot = false,
  });

  final String query;
  final String? cause;
  final String? city;
  final String sort;
  final List<DriveSummary> rows;
  final bool loading;
  final bool loadingMore;
  final bool endReached;
  final SoiError? error;

  /// True while showing the cached first page before the network answers.
  final bool fromSnapshot;

  bool get hasFilters => query.isNotEmpty || cause != null || city != null || sort != 'soonest';

  DiscoverState copyWith({
    String? query,
    String? cause,
    bool clearCause = false,
    String? city,
    bool clearCity = false,
    String? sort,
    List<DriveSummary>? rows,
    bool? loading,
    bool? loadingMore,
    bool? endReached,
    SoiError? error,
    bool clearError = false,
    bool? fromSnapshot,
  }) {
    return DiscoverState(
      query: query ?? this.query,
      cause: clearCause ? null : (cause ?? this.cause),
      city: clearCity ? null : (city ?? this.city),
      sort: sort ?? this.sort,
      rows: rows ?? this.rows,
      loading: loading ?? this.loading,
      loadingMore: loadingMore ?? this.loadingMore,
      endReached: endReached ?? this.endReached,
      error: clearError ? null : (error ?? this.error),
      fromSnapshot: fromSnapshot ?? this.fromSnapshot,
    );
  }
}

/// Search + filters + pagination for the Discover tab.
///
/// The first page is cached on device so a cold start paints instantly;
/// the network result replaces it. Every request carries a generation
/// number so a slow response from an old filter can never overwrite a
/// newer one.
@riverpod
class DiscoverController extends _$DiscoverController {
  int _generation = 0;
  Timer? _debounce;

  @override
  DiscoverState build() {
    ref.onDispose(() => _debounce?.cancel());
    final cached = ref.read(snapshotsProvider).discoverFirstPage();
    Future<void>.microtask(load);
    return DiscoverState(rows: cached, loading: cached.isEmpty, fromSnapshot: cached.isNotEmpty);
  }

  Future<void> load() async {
    final gen = ++_generation;
    state = state.copyWith(loading: state.rows.isEmpty, clearError: true, endReached: false);
    try {
      final rows = await ref.read(drivesRepoProvider).discover(
            query: state.query.isEmpty ? null : state.query,
            cause: state.cause,
            city: state.city,
            sort: state.sort,
          );
      if (gen != _generation) return;
      state = state.copyWith(
        rows: rows,
        loading: false,
        endReached: rows.length < DrivesRepo.pageSize,
        fromSnapshot: false,
      );
      if (!state.hasFilters) {
        await ref.read(snapshotsProvider).saveDiscoverFirstPage(rows);
      }
    } catch (e) {
      if (gen != _generation) return;
      state = state.copyWith(loading: false, error: SoiError.from(e), fromSnapshot: false);
    }
  }

  Future<void> loadMore() async {
    if (state.loadingMore || state.endReached || state.loading || state.error != null) return;
    final gen = _generation;
    state = state.copyWith(loadingMore: true);
    try {
      final more = await ref.read(drivesRepoProvider).discover(
            query: state.query.isEmpty ? null : state.query,
            cause: state.cause,
            city: state.city,
            sort: state.sort,
            offset: state.rows.length,
          );
      if (gen != _generation) return;
      final seen = state.rows.map((r) => r.id).toSet();
      state = state.copyWith(
        rows: [...state.rows, ...more.where((r) => !seen.contains(r.id))],
        loadingMore: false,
        endReached: more.length < DrivesRepo.pageSize,
      );
    } catch (e) {
      if (gen != _generation) return;
      state = state.copyWith(loadingMore: false, error: SoiError.from(e));
    }
  }

  Future<void> refresh() => load();

  void setQuery(String q) {
    final v = q.trim();
    if (v == state.query) return;
    state = state.copyWith(query: v);
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), load);
  }

  void setCause(String? cause) {
    state = cause == null ? state.copyWith(clearCause: true) : state.copyWith(cause: cause);
    load();
  }

  void setCity(String? city) {
    state = city == null ? state.copyWith(clearCity: true) : state.copyWith(city: city);
    load();
  }

  void setSort(String sort) {
    if (sort == state.sort) return;
    state = state.copyWith(sort: sort);
    load();
  }

  void clearFilters() {
    _debounce?.cancel();
    state = state.copyWith(query: '', clearCause: true, clearCity: true, sort: 'soonest');
    load();
  }

  /// Optimistic update after registering / cancelling from the detail page.
  void patchRegistration(String driveId, {required bool registered, required int spotsLeft}) {
    state = state.copyWith(
      rows: [
        for (final r in state.rows)
          if (r.id == driveId) r.copyWith(registered: registered, spotsLeft: spotsLeft) else r,
      ],
    );
  }
}

@riverpod
Future<Facets> discoverFacets(Ref ref) => ref.watch(drivesRepoProvider).facets();
