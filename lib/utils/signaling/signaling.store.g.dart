// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signaling.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignalingStore on _SignalingStore, Store {
  late final _$candidatesAtom =
      Atom(name: '_SignalingStore.candidates', context: context);

  @override
  List<Map<String, dynamic>>? get candidates {
    _$candidatesAtom.reportRead();
    return super.candidates;
  }

  @override
  set candidates(List<Map<String, dynamic>>? value) {
    _$candidatesAtom.reportWrite(value, super.candidates, () {
      super.candidates = value;
    });
  }

  late final _$_SignalingStoreActionController =
      ActionController(name: '_SignalingStore', context: context);

  @override
  void setCandidates(List<Map<String, dynamic>> c) {
    final _$actionInfo = _$_SignalingStoreActionController.startAction(
        name: '_SignalingStore.setCandidates');
    try {
      return super.setCandidates(c);
    } finally {
      _$_SignalingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
candidates: ${candidates}
    ''';
  }
}
