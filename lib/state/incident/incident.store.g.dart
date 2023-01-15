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

  late final _$loadingAtom =
      Atom(name: '_IncidentStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
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
  void setMapController(GoogleMapController c) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setMapController');
    try {
      return super.setMapController(c);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool l) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setLoading');
    try {
      return super.setLoading(l);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlayer(VideoPlayerController c) {
    final _$actionInfo = _$_IncidentStoreActionController.startAction(
        name: '_IncidentStore.setPlayer');
    try {
      return super.setPlayer(c);
    } finally {
      _$_IncidentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollController: ${scrollController},
contacts: ${contacts},
contactPopupController: ${contactPopupController},
contactPopupValuesController: ${contactPopupValuesController},
incidentId: ${incidentId},
controller: ${controller},
playController: ${playController},
mapStyle: ${mapStyle},
mapController: ${mapController},
loading: ${loading},
player: ${player}
    ''';
  }
}
