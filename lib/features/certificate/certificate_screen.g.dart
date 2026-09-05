// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(certificate)
final certificateProvider = CertificateFamily._();

final class CertificateProvider
    extends
        $FunctionalProvider<
          AsyncValue<Certificate>,
          Certificate,
          FutureOr<Certificate>
        >
    with $FutureModifier<Certificate>, $FutureProvider<Certificate> {
  CertificateProvider._({
    required CertificateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'certificateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$certificateHash();

  @override
  String toString() {
    return r'certificateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Certificate> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Certificate> create(Ref ref) {
    final argument = this.argument as String;
    return certificate(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CertificateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$certificateHash() => r'e309426871c2a84787e61c47695bdc35c3ab8983';

final class CertificateFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Certificate>, String> {
  CertificateFamily._()
    : super(
        retry: null,
        name: r'certificateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CertificateProvider call(String code) =>
      CertificateProvider._(argument: code, from: this);

  @override
  String toString() => r'certificateProvider';
}
