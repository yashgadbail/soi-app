// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_pledges_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pledgeSigners)
final pledgeSignersProvider = PledgeSignersFamily._();

final class PledgeSignersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Signer>>,
          List<Signer>,
          FutureOr<List<Signer>>
        >
    with $FutureModifier<List<Signer>>, $FutureProvider<List<Signer>> {
  PledgeSignersProvider._({
    required PledgeSignersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pledgeSignersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pledgeSignersHash();

  @override
  String toString() {
    return r'pledgeSignersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Signer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Signer>> create(Ref ref) {
    final argument = this.argument as String;
    return pledgeSigners(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PledgeSignersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pledgeSignersHash() => r'61d06701f07907666113403a13f83b7c630f0084';

final class PledgeSignersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Signer>>, String> {
  PledgeSignersFamily._()
    : super(
        retry: null,
        name: r'pledgeSignersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PledgeSignersProvider call(String id) =>
      PledgeSignersProvider._(argument: id, from: this);

  @override
  String toString() => r'pledgeSignersProvider';
}
