// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repositories.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Thin, typed wrappers over the server functions. One method per RPC; the
/// names match db/migrations so the contract is greppable. Every call is
/// wrapped in [guard] so callers only ever see [SoiError].
///
/// No repository writes to a table directly. That is a property of the
/// database (no client write policies), not just a convention here.

@ProviderFor(supabase)
final supabaseProvider = SupabaseProvider._();

/// Thin, typed wrappers over the server functions. One method per RPC; the
/// names match db/migrations so the contract is greppable. Every call is
/// wrapped in [guard] so callers only ever see [SoiError].
///
/// No repository writes to a table directly. That is a property of the
/// database (no client write policies), not just a convention here.

final class SupabaseProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  /// Thin, typed wrappers over the server functions. One method per RPC; the
  /// names match db/migrations so the contract is greppable. Every call is
  /// wrapped in [guard] so callers only ever see [SoiError].
  ///
  /// No repository writes to a table directly. That is a property of the
  /// database (no client write policies), not just a convention here.
  SupabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseHash() => r'7750c766113ae9b14a18705c73c53e2e92e2ddbd';

@ProviderFor(drivesRepo)
final drivesRepoProvider = DrivesRepoProvider._();

final class DrivesRepoProvider
    extends $FunctionalProvider<DrivesRepo, DrivesRepo, DrivesRepo>
    with $Provider<DrivesRepo> {
  DrivesRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'drivesRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$drivesRepoHash();

  @$internal
  @override
  $ProviderElement<DrivesRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DrivesRepo create(Ref ref) {
    return drivesRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DrivesRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DrivesRepo>(value),
    );
  }
}

String _$drivesRepoHash() => r'11847e831225ad9a20248b0ced5862529d8c674f';

@ProviderFor(orgsRepo)
final orgsRepoProvider = OrgsRepoProvider._();

final class OrgsRepoProvider
    extends $FunctionalProvider<OrgsRepo, OrgsRepo, OrgsRepo>
    with $Provider<OrgsRepo> {
  OrgsRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orgsRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orgsRepoHash();

  @$internal
  @override
  $ProviderElement<OrgsRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrgsRepo create(Ref ref) {
    return orgsRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrgsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrgsRepo>(value),
    );
  }
}

String _$orgsRepoHash() => r'8b8cedebf9276611a2f148f85db5bb1081e07cdf';

@ProviderFor(pledgesRepo)
final pledgesRepoProvider = PledgesRepoProvider._();

final class PledgesRepoProvider
    extends $FunctionalProvider<PledgesRepo, PledgesRepo, PledgesRepo>
    with $Provider<PledgesRepo> {
  PledgesRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pledgesRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pledgesRepoHash();

  @$internal
  @override
  $ProviderElement<PledgesRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PledgesRepo create(Ref ref) {
    return pledgesRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PledgesRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PledgesRepo>(value),
    );
  }
}

String _$pledgesRepoHash() => r'c80ed22379e9e38b8d6f811b614b161b4fe6719c';

@ProviderFor(accountRepo)
final accountRepoProvider = AccountRepoProvider._();

final class AccountRepoProvider
    extends $FunctionalProvider<AccountRepo, AccountRepo, AccountRepo>
    with $Provider<AccountRepo> {
  AccountRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountRepoHash();

  @$internal
  @override
  $ProviderElement<AccountRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AccountRepo create(Ref ref) {
    return accountRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountRepo>(value),
    );
  }
}

String _$accountRepoHash() => r'13617f2ff4a672497e3367a8d5f2e9878dbb204f';

@ProviderFor(authRepo)
final authRepoProvider = AuthRepoProvider._();

final class AuthRepoProvider
    extends $FunctionalProvider<AuthRepo, AuthRepo, AuthRepo>
    with $Provider<AuthRepo> {
  AuthRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepoHash();

  @$internal
  @override
  $ProviderElement<AuthRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepo create(Ref ref) {
    return authRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepo>(value),
    );
  }
}

String _$authRepoHash() => r'b6bf4e4630f7a1661d757d8e85553433509ba763';
