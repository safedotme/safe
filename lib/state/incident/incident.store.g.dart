// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IncidentStore on _IncidentStore, Store {
  late final _$scrollControllerAtom =
      Atom(name: '_IncidentStore.scrollController', context: context);

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

  late final _$incidentIdAtom =
      Atom(name: '_IncidentStore.incidentId', context: context);

  @override
  String? get incidentId {
    _$incidentIdAtom.reportRead();
    return super.incidentId;
  }

  @override
  set incidentId(String? value) {
    _$incidentIdAtom.reportWrite(value, super.incidentId, () {
      super.incidentId = value;
    });
  }

  late final _$controllerAtom =
      Atom(name: '_IncidentStore.controller', context: context);

  @override
  ScreenTransitionController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(ScreenTransitionController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  late final _$menuControllerAtom =
      Atom(name: '_IncidentStore.menuController', context: context);

  @override
  ContextMenuController get menuController {
    _$menuControllerAtom.reportRead();
    return super.menuController;
  }

  @override
  set menuController(ContextMenuController value) {
    _$menuControllerAtom.reportWrite(value, super.menuController, () {
      super.menuController = value;
    });
  }

  late final _$mapStyleAtom =
      Atom(name: '_IncidentStore.mapStyle', context: context);

  @override
  String? get mapStyle {
    _$mapStyleAtom.reportRead();
    return super.mapStyle;
  }

  @override
  set mapStyle(String? value) {
    _$mapStyleAtom.reportWrite(value, super.mapStyle, () {
      super.mapStyle = value;
    });
  }

  late final _$_IncidentStoreActionController =
      ActionController(name: '_IncidentStore', context: context);

  @override
  void setIncidentId(String id) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setIncidentId');
    try {
      return super.setIncidentId(id);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMapStyle(String s) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setMapStyle');
    try {
      return super.setMapStyle(s);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollController: ${scrollController},
incidentId: ${incidentId},
controller: ${controller},
menuController: ${menuController},
mapStyle: ${mapStyle}
    ''';
  }
}
