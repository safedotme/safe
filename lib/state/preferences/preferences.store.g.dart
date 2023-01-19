// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PreferencesStore on _PreferencesStore, Store {
  late final _$languageAtom =
      Atom(name: '_PreferencesStore.language', context: context);

  @override
  Languages get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  @override
  set language(Languages value) {
    _$languageAtom.reportWrite(value, super.language, () {
      super.language = value;
    });
  }

  late final _$disabledPermissionsAtom =
      Atom(name: '_PreferencesStore.disabledPermissions', context: context);

  @override
  List<Permission> get disabledPermissions {
    _$disabledPermissionsAtom.reportRead();
    return super.disabledPermissions;
  }

  @override
  set disabledPermissions(List<Permission> value) {
    _$disabledPermissionsAtom.reportWrite(value, super.disabledPermissions, () {
      super.disabledPermissions = value;
    });
  }

  late final _$actionControllerAtom =
      Atom(name: '_PreferencesStore.actionController', context: context);

  @override
  ActionBannerController get actionController {
    _$actionControllerAtom.reportRead();
    return super.actionController;
  }

  @override
  set actionController(ActionBannerController value) {
    _$actionControllerAtom.reportWrite(value, super.actionController, () {
      super.actionController = value;
    });
  }

  late final _$isConnectedAtom =
      Atom(name: '_PreferencesStore.isConnected', context: context);

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  late final _$biometricsEnabledAtom =
      Atom(name: '_PreferencesStore.biometricsEnabled', context: context);

  @override
  bool? get biometricsEnabled {
    _$biometricsEnabledAtom.reportRead();
    return super.biometricsEnabled;
  }

  @override
  set biometricsEnabled(bool? value) {
    _$biometricsEnabledAtom.reportWrite(value, super.biometricsEnabled, () {
      super.biometricsEnabled = value;
    });
  }

  late final _$controllerAtom =
      Atom(name: '_PreferencesStore.controller', context: context);

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

  late final _$scrollControllerAtom =
      Atom(name: '_PreferencesStore.scrollController', context: context);

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
      Atom(name: '_PreferencesStore.overlayController', context: context);

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

  late final _$overlayTextAtom =
      Atom(name: '_PreferencesStore.overlayText', context: context);

  @override
  String get overlayText {
    _$overlayTextAtom.reportRead();
    return super.overlayText;
  }

  @override
  set overlayText(String value) {
    _$overlayTextAtom.reportWrite(value, super.overlayText, () {
      super.overlayText = value;
    });
  }

  late final _$_PreferencesStoreActionController =
      ActionController(name: '_PreferencesStore', context: context);

  @override
  void setLanguage(Languages l) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setLanguage');
    try {
      return super.setLanguage(l);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDisabledPermissions(List<Permission> p) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setDisabledPermissions');
    try {
      return super.setDisabledPermissions(p);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsConnected(bool b) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setIsConnected');
    try {
      return super.setIsConnected(b);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBiometricsEnabled(bool? v) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setBiometricsEnabled');
    try {
      return super.setBiometricsEnabled(v);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOverlayText(String s) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setOverlayText');
    try {
      return super.setOverlayText(s);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
language: ${language},
disabledPermissions: ${disabledPermissions},
actionController: ${actionController},
isConnected: ${isConnected},
biometricsEnabled: ${biometricsEnabled},
controller: ${controller},
scrollController: ${scrollController},
overlayController: ${overlayController},
overlayText: ${overlayText}
    ''';
  }
}
