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

  late final _$controlPanelControllerAtom =
      Atom(name: '_CaptureStore.controlPanelController', context: context);

  @override
  PanelController get controlPanelController {
    _$controlPanelControllerAtom.reportRead();
    return super.controlPanelController;
  }

  @override
  set controlPanelController(PanelController value) {
    _$controlPanelControllerAtom
        .reportWrite(value, super.controlPanelController, () {
      super.controlPanelController = value;
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

  late final _$showPreviewAtom =
      Atom(name: '_CaptureStore.showPreview', context: context);

  @override
  Function? get showPreview {
    _$showPreviewAtom.reportRead();
    return super.showPreview;
  }

  @override
  set showPreview(Function? value) {
    _$showPreviewAtom.reportWrite(value, super.showPreview, () {
      super.showPreview = value;
    });
  }

  late final _$hidePreviewAtom =
      Atom(name: '_CaptureStore.hidePreview', context: context);

  @override
  Function? get hidePreview {
    _$hidePreviewAtom.reportRead();
    return super.hidePreview;
  }

  @override
  set hidePreview(Function? value) {
    _$hidePreviewAtom.reportWrite(value, super.hidePreview, () {
      super.hidePreview = value;
    });
  }

  late final _$phoneTallyAtom =
      Atom(name: '_CaptureStore.phoneTally', context: context);

  @override
  List<Map<String, int>> get phoneTally {
    _$phoneTallyAtom.reportRead();
    return super.phoneTally;
  }

  @override
  set phoneTally(List<Map<String, int>> value) {
    _$phoneTallyAtom.reportWrite(value, super.phoneTally, () {
      super.phoneTally = value;
    });
  }

  late final _$isBackCamAtom =
      Atom(name: '_CaptureStore.isBackCam', context: context);

  @override
  bool get isBackCam {
    _$isBackCamAtom.reportRead();
    return super.isBackCam;
  }

  @override
  set isBackCam(bool value) {
    _$isBackCamAtom.reportWrite(value, super.isBackCam, () {
      super.isBackCam = value;
    });
  }

  late final _$enlargementStateAtom =
      Atom(name: '_CaptureStore.enlargementState', context: context);

  @override
  double get enlargementState {
    _$enlargementStateAtom.reportRead();
    return super.enlargementState;
  }

  @override
  set enlargementState(double value) {
    _$enlargementStateAtom.reportWrite(value, super.enlargementState, () {
      super.enlargementState = value;
    });
  }

  late final _$enlargeCameraViewAtom =
      Atom(name: '_CaptureStore.enlargeCameraView', context: context);

  @override
  Function? get enlargeCameraView {
    _$enlargeCameraViewAtom.reportRead();
    return super.enlargeCameraView;
  }

  @override
  set enlargeCameraView(Function? value) {
    _$enlargeCameraViewAtom.reportWrite(value, super.enlargeCameraView, () {
      super.enlargeCameraView = value;
    });
  }

  late final _$unEnlargeCameraViewAtom =
      Atom(name: '_CaptureStore.unEnlargeCameraView', context: context);

  @override
  Function? get unEnlargeCameraView {
    _$unEnlargeCameraViewAtom.reportRead();
    return super.unEnlargeCameraView;
  }

  @override
  set unEnlargeCameraView(Function? value) {
    _$unEnlargeCameraViewAtom.reportWrite(value, super.unEnlargeCameraView, () {
      super.unEnlargeCameraView = value;
    });
  }

  late final _$isFlashOnAtom =
      Atom(name: '_CaptureStore.isFlashOn', context: context);

  @override
  bool get isFlashOn {
    _$isFlashOnAtom.reportRead();
    return super.isFlashOn;
  }

  @override
  set isFlashOn(bool value) {
    _$isFlashOnAtom.reportWrite(value, super.isFlashOn, () {
      super.isFlashOn = value;
    });
  }

  late final _$settingsAtom =
      Atom(name: '_CaptureStore.settings', context: context);

  @override
  AdminSettings? get settings {
    _$settingsAtom.reportRead();
    return super.settings;
  }

  @override
  set settings(AdminSettings? value) {
    _$settingsAtom.reportWrite(value, super.settings, () {
      super.settings = value;
    });
  }

  late final _$shouldFlashLimitBannerAtom =
      Atom(name: '_CaptureStore.shouldFlashLimitBanner', context: context);

  @override
  bool get shouldFlashLimitBanner {
    _$shouldFlashLimitBannerAtom.reportRead();
    return super.shouldFlashLimitBanner;
  }

  @override
  set shouldFlashLimitBanner(bool value) {
    _$shouldFlashLimitBannerAtom
        .reportWrite(value, super.shouldFlashLimitBanner, () {
      super.shouldFlashLimitBanner = value;
    });
  }

  late final _$limErrStateAtom =
      Atom(name: '_CaptureStore.limErrState', context: context);

  @override
  LimitErrorState? get limErrState {
    _$limErrStateAtom.reportRead();
    return super.limErrState;
  }

  @override
  set limErrState(LimitErrorState? value) {
    _$limErrStateAtom.reportWrite(value, super.limErrState, () {
      super.limErrState = value;
    });
  }

  late final _$errorCapturingAtom =
      Atom(name: '_CaptureStore.errorCapturing', context: context);

  @override
  String? get errorCapturing {
    _$errorCapturingAtom.reportRead();
    return super.errorCapturing;
  }

  @override
  set errorCapturing(String? value) {
    _$errorCapturingAtom.reportWrite(value, super.errorCapturing, () {
      super.errorCapturing = value;
    });
  }

  late final _$limErrorBannerControllerAtom =
      Atom(name: '_CaptureStore.limErrorBannerController', context: context);

  @override
  PanelController get limErrorBannerController {
    _$limErrorBannerControllerAtom.reportRead();
    return super.limErrorBannerController;
  }

  @override
  set limErrorBannerController(PanelController value) {
    _$limErrorBannerControllerAtom
        .reportWrite(value, super.limErrorBannerController, () {
      super.limErrorBannerController = value;
    });
  }

  late final _$incidentRecordedBannerPanelControllerAtom = Atom(
      name: '_CaptureStore.incidentRecordedBannerPanelController',
      context: context);

  @override
  PanelController get incidentRecordedBannerPanelController {
    _$incidentRecordedBannerPanelControllerAtom.reportRead();
    return super.incidentRecordedBannerPanelController;
  }

  @override
  set incidentRecordedBannerPanelController(PanelController value) {
    _$incidentRecordedBannerPanelControllerAtom
        .reportWrite(value, super.incidentRecordedBannerPanelController, () {
      super.incidentRecordedBannerPanelController = value;
    });
  }

  late final _$flashButtonControllerAtom =
      Atom(name: '_CaptureStore.flashButtonController', context: context);

  @override
  ControlButtonController get flashButtonController {
    _$flashButtonControllerAtom.reportRead();
    return super.flashButtonController;
  }

  @override
  set flashButtonController(ControlButtonController value) {
    _$flashButtonControllerAtom.reportWrite(value, super.flashButtonController,
        () {
      super.flashButtonController = value;
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
  void setShowPreview(Function? s) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setShowPreview');
    try {
      return super.setShowPreview(s);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHidePreview(Function? s) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setHidePreview');
    try {
      return super.setHidePreview(s);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneTally(List<Map<String, int>> t) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setPhoneTally');
    try {
      return super.setPhoneTally(t);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCam() {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.changeCam');
    try {
      return super.changeCam();
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEnglargmentState(double e) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setEnglargmentState');
    try {
      return super.setEnglargmentState(e);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEnlargeFn(Function enlarge, Function unEnlarge) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setEnlargeFn');
    try {
      return super.setEnlargeFn(enlarge, unEnlarge);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFlash() {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setFlash');
    try {
      return super.setFlash();
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSettings(AdminSettings s) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setSettings');
    try {
      return super.setSettings(s);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFlashLimitBanner(bool b) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setFlashLimitBanner');
    try {
      return super.setFlashLimitBanner(b);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLimErrState(LimitErrorState? s) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setLimErrState');
    try {
      return super.setLimErrState(s);
    } finally {
      _$_CaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorCapturing(String? s) {
    final _$actionInfo = _$_CaptureStoreActionController.startAction(
        name: '_CaptureStore.setErrorCapturing');
    try {
      return super.setErrorCapturing(s);
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
controlPanelController: ${controlPanelController},
offset: ${offset},
panelHeight: ${panelHeight},
hintTextIndex: ${hintTextIndex},
incident: ${incident},
type: ${type},
locationUpdates: ${locationUpdates},
overlayController: ${overlayController},
battery: ${battery},
engine: ${engine},
showPreview: ${showPreview},
hidePreview: ${hidePreview},
phoneTally: ${phoneTally},
isBackCam: ${isBackCam},
enlargementState: ${enlargementState},
enlargeCameraView: ${enlargeCameraView},
unEnlargeCameraView: ${unEnlargeCameraView},
isFlashOn: ${isFlashOn},
settings: ${settings},
shouldFlashLimitBanner: ${shouldFlashLimitBanner},
limErrState: ${limErrState},
errorCapturing: ${errorCapturing},
limErrorBannerController: ${limErrorBannerController},
incidentRecordedBannerPanelController: ${incidentRecordedBannerPanelController},
flashButtonController: ${flashButtonController}
    ''';
  }
}
