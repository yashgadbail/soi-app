// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pledge_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pledgeDetail)
final pledgeDetailProvider = PledgeDetailFamily._();

final class PledgeDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PledgeDetail>,
          PledgeDetail,
          FutureOr<PledgeDetail>
        >
    with $FutureModifier<PledgeDetail>, $FutureProvider<PledgeDetail> {
  PledgeDetailProvider._({
    required PledgeDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pledgeDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pledgeDetailHash();

  @override
  String toString() {
    return r'pledgeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PledgeDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PledgeDetail> create(Ref ref) {
    final argument = this.argument as String;
    return pledgeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PledgeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pledgeDetailHash() => r'f9aefc1d8f639e64adb27ee9ce44d4a7b7980af4';

final class PledgeDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PledgeDetail>, String> {
  PledgeDetailFamily._()
    : super(
        retry: null,
        name: r'pledgeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PledgeDetailProvider call(String code) =>
      PledgeDetailProvider._(argument: code, from: this);

  @override
  String toString() => r'pledgeDetailProvider';
}
