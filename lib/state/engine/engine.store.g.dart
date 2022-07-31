// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engine.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EngineStore on _EngineStore, Store {
  late final _$onStopAtom = Atom(name: '_EngineStore.onStop', context: context);

  @override
  bool get onStop {
    _$onStopAtom.reportRead();
    return super.onStop;
  }

  @override
  set onStop(bool value) {
    _$onStopAtom.reportWrite(value, super.onStop, () {
      super.onStop = value;
    });
  }

  late final _$countAtom = Atom(name: '_EngineStore.count', context: context);

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  late final _$backlogAtom =
      Atom(name: '_EngineStore.backlog', context: context);

  @override
  List<Map<String, dynamic>> get backlog {
    _$backlogAtom.reportRead();
    return super.backlog;
  }

  @override
  set backlog(List<Map<String, dynamic>> value) {
    _$backlogAtom.reportWrite(value, super.backlog, () {
      super.backlog = value;
    });
  }

  late final _$_EngineStoreActionController =
      ActionController(name: '_EngineStore', context: context);

  @override
  void setOnStop(bool v) {
    final _$actionInfo = _$_EngineStoreActionController.startAction(
        name: '_EngineStore.setOnStop');
    try {
      return super.setOnStop(v);
    } finally {
      _$_EngineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCount() {
    final _$actionInfo = _$_EngineStoreActionController.startAction(
        name: '_EngineStore.clearCount');
    try {
      return super.clearCount();
    } finally {
      _$_EngineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addCount() {
    final _$actionInfo = _$_EngineStoreActionController.startAction(
        name: '_EngineStore.addCount');
    try {
      return super.addCount();
    } finally {
      _$_EngineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToBacklog(Map<String, dynamic> b) {
    final _$actionInfo = _$_EngineStoreActionController.startAction(
        name: '_EngineStore.addToBacklog');
    try {
      return super.addToBacklog(b);
    } finally {
      _$_EngineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void takeJob(Map<String, dynamic> job) {
    final _$actionInfo = _$_EngineStoreActionController.startAction(
        name: '_EngineStore.takeJob');
    try {
      return super.takeJob(job);
    } finally {
      _$_EngineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void completeJob(Map<String, dynamic> job) {
    final _$actionInfo = _$_EngineStoreActionController.startAction(
        name: '_EngineStore.completeJob');
    try {
      return super.completeJob(job);
    } finally {
      _$_EngineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
onStop: ${onStop},
count: ${count},
backlog: ${backlog}
    ''';
  }
}
