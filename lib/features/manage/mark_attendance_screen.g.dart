// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_attendance_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(markCandidates)
final markCandidatesProvider = MarkCandidatesFamily._();

final class MarkCandidatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<({Set<String> marked, List<_Candidate> students})>,
          ({Set<String> marked, List<_Candidate> students}),
          FutureOr<({Set<String> marked, List<_Candidate> students})>
        >
    with
        $FutureModifier<({Set<String> marked, List<_Candidate> students})>,
        $FutureProvider<({Set<String> marked, List<_Candidate> students})> {
  MarkCandidatesProvider._({
    required MarkCandidatesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'markCandidatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$markCandidatesHash();

  @override
  String toString() {
    return r'markCandidatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<({Set<String> marked, List<_Candidate> students})>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<({Set<String> marked, List<_Candidate> students})> create(Ref ref) {
    final argument = this.argument as String;
    return markCandidates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MarkCandidatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$markCandidatesHash() => r'd9d163d089da59f21a09c1ddafa2fbbcc1cab4f8';

final class MarkCandidatesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<({Set<String> marked, List<_Candidate> students})>,
          String
        > {
  MarkCandidatesFamily._()
    : super(
        retry: null,
        name: r'markCandidatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MarkCandidatesProvider call(String driveId) =>
      MarkCandidatesProvider._(argument: driveId, from: this);

  @override
  String toString() => r'markCandidatesProvider';
}
