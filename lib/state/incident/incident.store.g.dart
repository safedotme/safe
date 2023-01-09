// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IncidentStore on _IncidentStore, Store {
  late final _$incidentAtom =
      Atom(name: '_IncidentStore.incident', context: context);

  @override
  Incident? get incident {
    _$incidentAtom.reportRead();
    return super.incident;
  }

  @override
  set incident(Incident? value) {
    _$incidentAtom.reportWrite(value, super.incident, () {
      super.incident = value;
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
  void setIncident(Incident i) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setIncident');
    try {
      return super.setIncident(i);
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
incident: ${incident},
controller: ${controller},
menuController: ${menuController},
mapStyle: ${mapStyle}
    ''';
  }
}
