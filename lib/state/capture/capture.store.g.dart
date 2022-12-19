// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CaptureStore on _CaptureStore, Store {
  late final _$controllerAtom =
      Atom(name: '_CaptureStore.controller', context: context);

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

  late final _$hintTextControllerAtom =
      Atom(name: '_CaptureStore.hintTextController', context: context);

  @override
  CaptureTextShimmerController get hintTextController {
    _$hintTextControllerAtom.reportRead();
    return super.hintTextController;
  }

  @override
  set hintTextController(CaptureTextShimmerController value) {
    _$hintTextControllerAtom.reportWrite(value, super.hintTextController, () {
      super.hintTextController = value;
    });
  }

  late final _$panelControllerAtom =
      Atom(name: '_CaptureStore.panelController', context: context);

  @override
  PanelController get panelController {
    _$panelControllerAtom.reportRead();
    return super.panelController;
  }

  @override
  set panelController(PanelController value) {
    _$panelControllerAtom.reportWrite(value, super.panelController, () {
      super.panelController = value;
    });
  }

  late final _$offsetAtom =
      Atom(name: '_CaptureStore.offset', context: context);

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

  late final _$panelHeightAtom =
      Atom(name: '_CaptureStore.panelHeight', context: context);

  @override
  double get panelHeight {
    _$panelHeightAtom.reportRead();
    return super.panelHeight;
  }

  @override
  set panelHeight(double value) {
    _$panelHeightAtom.reportWrite(value, super.panelHeight, () {
      super.panelHeight = value;
    });
  }

  late final _$hintTextIndexAtom =
      Atom(name: '_CaptureStore.hintTextIndex', context: context);

  @override
  int get hintTextIndex {
    _$hintTextIndexAtom.reportRead();
    return super.hintTextIndex;
  }

  @override
  set hintTextIndex(int value) {
    _$hintTextIndexAtom.reportWrite(value, super.hintTextIndex, () {
      super.hintTextIndex = value;
    });
  }

  late final _$incidentAtom =
      Atom(name: '_CaptureStore.incident', context: context);

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

  late final _$typeAtom = Atom(name: '_CaptureStore.type', context: context);

  @override
  IncidentType get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(IncidentType value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$locationUpdatesAtom =
      Atom(name: '_CaptureStore.locationUpdates', context: context);

  @override
  Stream<Location>? get locationUpdates {
    _$locationUpdatesAtom.reportRead();
    return super.locationUpdates;
  }

  @override
  set locationUpdates(Stream<Location>? value) {
    _$locationUpdatesAtom.reportWrite(value, super.locationUpdates, () {
      super.locationUpdates = value;
    });
  }

  late final _$overlayControllerAtom =
      Atom(name: '_CaptureStore.overlayController', context: context);

  @override
  OverlayController get overlayController {
    _$overlayControllerAtom.reportRead();
    return super.overlayController;
  }

  @override
  set overlayController(OverlayController value) {
    _$overlayControllerAtom.reportWrite(value, super.overlayController, () {
      super.overlayController = value;
    });
  }

  late final _$batteryAtom =
      Atom(name: '_CaptureStore.battery', context: context);

  @override
  List<Battery> get battery {
    _$batteryAtom.reportRead();
    return super.battery;
  }

  @override
  set battery(List<Battery> value) {
    _$batteryAtom.reportWrite(value, super.battery, () {
      super.battery = value;
    });
  }

  late final _$emergencyServicesNotifiedAtom =
      Atom(name: '_CaptureStore.emergencyServicesNotified', context: context);

  @override
  bool get emergencyServicesNotified {
    _$emergencyServicesNotifiedAtom.reportRead();
    return super.emergencyServicesNotified;
  }

  @override
  set emergencyServicesNotified(bool value) {
    _$emergencyServicesNotifiedAtom
        .reportWrite(value, super.emergencyServicesNotified, () {
      super.emergencyServicesNotified = value;
    });
  }

  late final _$engineAtom =
      Atom(name: '_CaptureStore.engine', context: context);

  @override
  RtcEngine? get engine {
    _$engineAtom.reportRead();
    return super.engine;
  }

  @override
  set engine(RtcEngine? value) {
    _$engineAtom.reportWrite(value, super.engine, () {
      super.engine = value;
    });
  }

  late final _$_CaptureStoreActionController =
      ActionController(name: '_CaptureStore', context: context);

  @override
  void setOffset(double d) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setOffset');
    try {
      return super.setOffset(d);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPanelHeight(double p) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setPanelHeight');
    try {
      return super.setPanelHeight(p);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHintTextIndex(int i) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setHintTextIndex');
    try {
      return super.setHintTextIndex(i);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIncident(Incident i) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setIncident');
    try {
      return super.setIncident(i);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIncidentType(IncidentType t) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setIncidentType');
    try {
      return super.setIncidentType(t);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocationUpdates(Stream<Location> l) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setLocationUpdates');
    try {
      return super.setLocationUpdates(l);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToBattery(Battery b) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.addToBattery');
    try {
      return super.addToBattery(b);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmergencyServicesNotified(bool b) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setEmergencyServicesNotified');
    try {
      return super.setEmergencyServicesNotified(b);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEngine(RtcEngine e) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setEngine');
    try {
      return super.setEngine(e);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controller: ${controller},
hintTextController: ${hintTextController},
panelController: ${panelController},
offset: ${offset},
panelHeight: ${panelHeight},
hintTextIndex: ${hintTextIndex},
incident: ${incident},
type: ${type},
locationUpdates: ${locationUpdates},
overlayController: ${overlayController},
battery: ${battery},
emergencyServicesNotified: ${emergencyServicesNotified},
engine: ${engine}
    ''';
  }
}
