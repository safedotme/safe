// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_log.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IncidentLogStore on _IncidentLogStore, Store {
  late final _$controllerAtom =
      Atom(name: '_IncidentLogStore.controller', context: context);

  @override
  PanelController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(PanelController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  late final _$offsetAtom =
      Atom(name: '_IncidentLogStore.offset', context: context);

  @override
  double get offset {
    _$offsetAtom.reportRead();
    return super.offset;
  }

  @override
  set offset(double value) {
    _$offsetAtom.reportWrite(value, super.offset, () {
      super.offset = value;
    });
  }

  late final _$scrollControllerAtom =
      Atom(name: '_IncidentLogStore.scrollController', context: context);

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  late final _$scrollPhysicsAtom =
      Atom(name: '_IncidentLogStore.scrollPhysics', context: context);

  @override
  ScrollPhysics? get scrollPhysics {
    _$scrollPhysicsAtom.reportRead();
    return super.scrollPhysics;
  }

  @override
  set scrollPhysics(ScrollPhysics? value) {
    _$scrollPhysicsAtom.reportWrite(value, super.scrollPhysics, () {
      super.scrollPhysics = value;
    });
  }

  late final _$incidentsAtom =
      Atom(name: '_IncidentLogStore.incidents', context: context);

  @override
  List<Incident>? get incidents {
    _$incidentsAtom.reportRead();
    return super.incidents;
  }

  @override
  set incidents(List<Incident>? value) {
    _$incidentsAtom.reportWrite(value, super.incidents, () {
      super.incidents = value;
    });
  }

  late final _$scrollOffsetAtom =
      Atom(name: '_IncidentLogStore.scrollOffset', context: context);

  @override
  double get scrollOffset {
    _$scrollOffsetAtom.reportRead();
    return super.scrollOffset;
  }

  @override
  set scrollOffset(double value) {
    _$scrollOffsetAtom.reportWrite(value, super.scrollOffset, () {
      super.scrollOffset = value;
    });
  }

  late final _$userAtom =
      Atom(name: '_IncidentLogStore.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$_IncidentLogStoreActionController =
      ActionController(name: '_IncidentLogStore', context: context);

  @override
  void setOffset(double o) {
    final _$actionInfo = _$_IncidentLogStoreActionController.startAction(
        name: '_IncidentLogStore.setOffset');
    try {
      return super.setOffset(o);
    } finally {
      _$_IncidentLogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setScrollPhysics(ScrollPhysics? p) {
    final _$actionInfo = _$_IncidentLogStoreActionController.startAction(
        name: '_IncidentLogStore.setScrollPhysics');
    try {
      return super.setScrollPhysics(p);
    } finally {
      _$_IncidentLogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIncidents(List<Incident>? i) {
    final _$actionInfo = _$_IncidentLogStoreActionController.startAction(
        name: '_IncidentLogStore.setIncidents');
    try {
      return super.setIncidents(i);
    } finally {
      _$_IncidentLogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setScrollOffset(double o) {
    final _$actionInfo = _$_IncidentLogStoreActionController.startAction(
        name: '_IncidentLogStore.setScrollOffset');
    try {
      return super.setScrollOffset(o);
    } finally {
      _$_IncidentLogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUser(User u) {
    final _$actionInfo = _$_IncidentLogStoreActionController.startAction(
        name: '_IncidentLogStore.setUser');
    try {
      return super.setUser(u);
    } finally {
      _$_IncidentLogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controller: ${controller},
offset: ${offset},
scrollController: ${scrollController},
scrollPhysics: ${scrollPhysics},
incidents: ${incidents},
scrollOffset: ${scrollOffset},
user: ${user}
    ''';
  }
}
