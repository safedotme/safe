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

  late final _$cameraAtom =
      Atom(name: '_CaptureStore.camera', context: context);

  @override
  CameraController? get camera {
    _$cameraAtom.reportRead();
    return super.camera;
  }

  @override
  set camera(CameraController? value) {
    _$cameraAtom.reportWrite(value, super.camera, () {
      super.camera = value;
    });
  }

  late final _$camerasAtom =
      Atom(name: '_CaptureStore.cameras', context: context);

  @override
  List<CameraDescription> get cameras {
    _$camerasAtom.reportRead();
    return super.cameras;
  }

  @override
  set cameras(List<CameraDescription> value) {
    _$camerasAtom.reportWrite(value, super.cameras, () {
      super.cameras = value;
    });
  }

  late final _$isCameraInitializedAtom =
      Atom(name: '_CaptureStore.isCameraInitialized', context: context);

  @override
  bool get isCameraInitialized {
    _$isCameraInitializedAtom.reportRead();
    return super.isCameraInitialized;
  }

  @override
  set isCameraInitialized(bool value) {
    _$isCameraInitializedAtom.reportWrite(value, super.isCameraInitialized, () {
      super.isCameraInitialized = value;
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

  late final _$cameraPreviewControllerAtom =
      Atom(name: '_CaptureStore.cameraPreviewController', context: context);

  @override
  CameraPreviewController get cameraPreviewController {
    _$cameraPreviewControllerAtom.reportRead();
    return super.cameraPreviewController;
  }

  @override
  set cameraPreviewController(CameraPreviewController value) {
    _$cameraPreviewControllerAtom
        .reportWrite(value, super.cameraPreviewController, () {
      super.cameraPreviewController = value;
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

  late final _$onStopAtom =
      Atom(name: '_CaptureStore.onStop', context: context);

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

  late final _$countAtom = Atom(name: '_CaptureStore.count', context: context);

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
      Atom(name: '_CaptureStore.backlog', context: context);

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

  late final _$_CaptureStoreActionController =
      ActionController(name: '_CaptureStore', context: context);

  @override
  void setCamera(CameraController c) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setCamera');
    try {
      return super.setCamera(c);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCameras(List<CameraDescription> c) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setCameras');
    try {
      return super.setCameras(c);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsCameraInitialized(bool v) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setIsCameraInitialized');
    try {
      return super.setIsCameraInitialized(v);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

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
  void setOnStop(bool v) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setOnStop');
    try {
      return super.setOnStop(v);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCount() {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.clearCount');
    try {
      return super.clearCount();
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addCount() {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.addCount');
    try {
      return super.addCount();
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToBacklog(Map<String, dynamic> b) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.addToBacklog');
    try {
      return super.addToBacklog(b);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void takeJob(Map<String, dynamic> job) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.takeJob');
    try {
      return super.takeJob(job);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void completeJob(Map<String, dynamic> job) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.completeJob');
    try {
      return super.completeJob(job);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controller: ${controller},
hintTextController: ${hintTextController},
camera: ${camera},
cameras: ${cameras},
isCameraInitialized: ${isCameraInitialized},
panelController: ${panelController},
offset: ${offset},
panelHeight: ${panelHeight},
hintTextIndex: ${hintTextIndex},
cameraPreviewController: ${cameraPreviewController},
incident: ${incident},
type: ${type},
locationUpdates: ${locationUpdates},
onStop: ${onStop},
overlayController: ${overlayController},
count: ${count},
backlog: ${backlog}
    ''';
  }
}
