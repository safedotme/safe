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

  late final _$overlayControllerAtom =
      Atom(name: '_IncidentStore.overlayController', context: context);

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

  late final _$contactsAtom =
      Atom(name: '_IncidentStore.contacts', context: context);

  @override
  List<NotifiedContact> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<NotifiedContact> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$widgetShowcasePopupControllerAtom = Atom(
      name: '_IncidentStore.widgetShowcasePopupController', context: context);

  @override
  PanelController get widgetShowcasePopupController {
    _$widgetShowcasePopupControllerAtom.reportRead();
    return super.widgetShowcasePopupController;
  }

  @override
  set widgetShowcasePopupController(PanelController value) {
    _$widgetShowcasePopupControllerAtom
        .reportWrite(value, super.widgetShowcasePopupController, () {
      super.widgetShowcasePopupController = value;
    });
  }

  late final _$contactPopupControllerAtom =
      Atom(name: '_IncidentStore.contactPopupController', context: context);

  @override
  PanelController get contactPopupController {
    _$contactPopupControllerAtom.reportRead();
    return super.contactPopupController;
  }

  @override
  set contactPopupController(PanelController value) {
    _$contactPopupControllerAtom
        .reportWrite(value, super.contactPopupController, () {
      super.contactPopupController = value;
    });
  }

  late final _$contactPopupValuesControllerAtom = Atom(
      name: '_IncidentStore.contactPopupValuesController', context: context);

  @override
  EmergencyContactPopupController get contactPopupValuesController {
    _$contactPopupValuesControllerAtom.reportRead();
    return super.contactPopupValuesController;
  }

  @override
  set contactPopupValuesController(EmergencyContactPopupController value) {
    _$contactPopupValuesControllerAtom
        .reportWrite(value, super.contactPopupValuesController, () {
      super.contactPopupValuesController = value;
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

  late final _$playControllerAtom =
      Atom(name: '_IncidentStore.playController', context: context);

  @override
  ScreenTransitionController get playController {
    _$playControllerAtom.reportRead();
    return super.playController;
  }

  @override
  set playController(ScreenTransitionController value) {
    _$playControllerAtom.reportWrite(value, super.playController, () {
      super.playController = value;
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

  late final _$isPlayerOpenAtom =
      Atom(name: '_IncidentStore.isPlayerOpen', context: context);

  @override
  bool get isPlayerOpen {
    _$isPlayerOpenAtom.reportRead();
    return super.isPlayerOpen;
  }

  @override
  set isPlayerOpen(bool value) {
    _$isPlayerOpenAtom.reportWrite(value, super.isPlayerOpen, () {
      super.isPlayerOpen = value;
    });
  }

  late final _$mapControllerAtom =
      Atom(name: '_IncidentStore.mapController', context: context);

  @override
  GoogleMapController? get mapController {
    _$mapControllerAtom.reportRead();
    return super.mapController;
  }

  @override
  set mapController(GoogleMapController? value) {
    _$mapControllerAtom.reportWrite(value, super.mapController, () {
      super.mapController = value;
    });
  }

  late final _$playerAtom =
      Atom(name: '_IncidentStore.player', context: context);

  @override
  VideoPlayerController? get player {
    _$playerAtom.reportRead();
    return super.player;
  }

  @override
  set player(VideoPlayerController? value) {
    _$playerAtom.reportWrite(value, super.player, () {
      super.player = value;
    });
  }

  late final _$isPlayingAtom =
      Atom(name: '_IncidentStore.isPlaying', context: context);

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$playDateAtom =
      Atom(name: '_IncidentStore.playDate', context: context);

  @override
  String get playDate {
    _$playDateAtom.reportRead();
    return super.playDate;
  }

  @override
  set playDate(String value) {
    _$playDateAtom.reportWrite(value, super.playDate, () {
      super.playDate = value;
    });
  }

  late final _$playTimeAtom =
      Atom(name: '_IncidentStore.playTime', context: context);

  @override
  String get playTime {
    _$playTimeAtom.reportRead();
    return super.playTime;
  }

  @override
  set playTime(String value) {
    _$playTimeAtom.reportWrite(value, super.playTime, () {
      super.playTime = value;
    });
  }

  late final _$playSpeedAtom =
      Atom(name: '_IncidentStore.playSpeed', context: context);

  @override
  String? get playSpeed {
    _$playSpeedAtom.reportRead();
    return super.playSpeed;
  }

  @override
  set playSpeed(String? value) {
    _$playSpeedAtom.reportWrite(value, super.playSpeed, () {
      super.playSpeed = value;
    });
  }

  late final _$playPositionAtom =
      Atom(name: '_IncidentStore.playPosition', context: context);

  @override
  LatLng? get playPosition {
    _$playPositionAtom.reportRead();
    return super.playPosition;
  }

  @override
  set playPosition(LatLng? value) {
    _$playPositionAtom.reportWrite(value, super.playPosition, () {
      super.playPosition = value;
    });
  }

  late final _$playBatteryAtom =
      Atom(name: '_IncidentStore.playBattery', context: context);

  @override
  String? get playBattery {
    _$playBatteryAtom.reportRead();
    return super.playBattery;
  }

  @override
  set playBattery(String? value) {
    _$playBatteryAtom.reportWrite(value, super.playBattery, () {
      super.playBattery = value;
    });
  }

  late final _$isBufferingAtom =
      Atom(name: '_IncidentStore.isBuffering', context: context);

  @override
  bool get isBuffering {
    _$isBufferingAtom.reportRead();
    return super.isBuffering;
  }

  @override
  set isBuffering(bool value) {
    _$isBufferingAtom.reportWrite(value, super.isBuffering, () {
      super.isBuffering = value;
    });
  }

  late final _$_IncidentStoreActionController =
      ActionController(name: '_IncidentStore', context: context);

  @override
  void setContacts(List<NotifiedContact> c) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setContacts');
    try {
      return super.setContacts(c);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

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
  void setIsPlayerOpen(bool b) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setIsPlayerOpen');
    try {
      return super.setIsPlayerOpen(b);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMapController(GoogleMapController? c) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setMapController');
    try {
      return super.setMapController(c);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlayer(VideoPlayerController? c) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setPlayer');
    try {
      return super.setPlayer(c);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsPlaying(bool v) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setIsPlaying');
    try {
      return super.setIsPlaying(v);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlayDate(String s) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setPlayDate');
    try {
      return super.setPlayDate(s);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlayTime(String s) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setPlayTime');
    try {
      return super.setPlayTime(s);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlaySpeed(String? s) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setPlaySpeed');
    try {
      return super.setPlaySpeed(s);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlayPosition(LatLng l) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setPlayPosition');
    try {
      return super.setPlayPosition(l);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlayBattery(String? s) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setPlayBattery');
    try {
      return super.setPlayBattery(s);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsBuffering(bool b) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setIsBuffering');
    try {
      return super.setIsBuffering(b);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollController: ${scrollController},
overlayController: ${overlayController},
contacts: ${contacts},
widgetShowcasePopupController: ${widgetShowcasePopupController},
contactPopupController: ${contactPopupController},
contactPopupValuesController: ${contactPopupValuesController},
incidentId: ${incidentId},
controller: ${controller},
playController: ${playController},
mapStyle: ${mapStyle},
isPlayerOpen: ${isPlayerOpen},
mapController: ${mapController},
player: ${player},
isPlaying: ${isPlaying},
playDate: ${playDate},
playTime: ${playTime},
playSpeed: ${playSpeed},
playPosition: ${playPosition},
playBattery: ${playBattery},
isBuffering: ${isBuffering}
    ''';
  }
}
