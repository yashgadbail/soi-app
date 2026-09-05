// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orgPublic)
final orgPublicProvider = OrgPublicFamily._();

final class OrgPublicProvider
    extends
        $FunctionalProvider<
          AsyncValue<OrgPublic>,
          OrgPublic,
          FutureOr<OrgPublic>
        >
    with $FutureModifier<OrgPublic>, $FutureProvider<OrgPublic> {
  OrgPublicProvider._({
    required OrgPublicFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orgPublicProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orgPublicHash();

  @override
  String toString() {
    return r'orgPublicProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<OrgPublic> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<OrgPublic> create(Ref ref) {
    final argument = this.argument as String;
    return orgPublic(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrgPublicProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orgPublicHash() => r'9309da180ba2f35b29c751a048a0e2b991dce19e';

final class OrgPublicFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<OrgPublic>, String> {
  OrgPublicFamily._()
    : super(
        retry: null,
        name: r'orgPublicProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrgPublicProvider call(String id) =>
      OrgPublicProvider._(argument: id, from: this);

  @override
  String toString() => r'orgPublicProvider';
}
