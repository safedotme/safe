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

  late final _$isFirstTimeAtom =
      Atom(name: '_PreferencesStore.isFirstTime', context: context);

  @override
  bool get isFirstTime {
    _$isFirstTimeAtom.reportRead();
    return super.isFirstTime;
  }

  @override
  set isFirstTime(bool value) {
    _$isFirstTimeAtom.reportWrite(value, super.isFirstTime, () {
      super.isFirstTime = value;
    });
  }

  late final _$confettiControllerAtom =
      Atom(name: '_PreferencesStore.confettiController', context: context);

  @override
  ConfettiController get confettiController {
    _$confettiControllerAtom.reportRead();
    return super.confettiController;
  }

  @override
  set confettiController(ConfettiController value) {
    _$confettiControllerAtom.reportWrite(value, super.confettiController, () {
      super.confettiController = value;
    });
  }

  late final _$seenWidgetPreviewAtom =
      Atom(name: '_PreferencesStore.seenWidgetPreview', context: context);

  @override
  bool get seenWidgetPreview {
    _$seenWidgetPreviewAtom.reportRead();
    return super.seenWidgetPreview;
  }

  @override
  set seenWidgetPreview(bool value) {
    _$seenWidgetPreviewAtom.reportWrite(value, super.seenWidgetPreview, () {
      super.seenWidgetPreview = value;
    });
  }

  late final _$tutorialCalledAtom =
      Atom(name: '_PreferencesStore.tutorialCalled', context: context);

  @override
  bool get tutorialCalled {
    _$tutorialCalledAtom.reportRead();
    return super.tutorialCalled;
  }

  @override
  set tutorialCalled(bool value) {
    _$tutorialCalledAtom.reportWrite(value, super.tutorialCalled, () {
      super.tutorialCalled = value;
    });
  }

  late final _$tutorialBannerControllerAtom = Atom(
      name: '_PreferencesStore.tutorialBannerController', context: context);

  @override
  PanelController get tutorialBannerController {
    _$tutorialBannerControllerAtom.reportRead();
    return super.tutorialBannerController;
  }

  @override
  set tutorialBannerController(PanelController value) {
    _$tutorialBannerControllerAtom
        .reportWrite(value, super.tutorialBannerController, () {
      super.tutorialBannerController = value;
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

  late final _$aboutContextMenuControllerAtom = Atom(
      name: '_PreferencesStore.aboutContextMenuController', context: context);

  @override
  custom.ContextMenuController get aboutContextMenuController {
    _$aboutContextMenuControllerAtom.reportRead();
    return super.aboutContextMenuController;
  }

  @override
  set aboutContextMenuController(custom.ContextMenuController value) {
    _$aboutContextMenuControllerAtom
        .reportWrite(value, super.aboutContextMenuController, () {
      super.aboutContextMenuController = value;
    });
  }

  late final _$contextMenuPosAtom =
      Atom(name: '_PreferencesStore.contextMenuPos', context: context);

  @override
  double get contextMenuPos {
    _$contextMenuPosAtom.reportRead();
    return super.contextMenuPos;
  }

  @override
  set contextMenuPos(double value) {
    _$contextMenuPosAtom.reportWrite(value, super.contextMenuPos, () {
      super.contextMenuPos = value;
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
  void setIsFirstTime(bool v) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setIsFirstTime');
    try {
      return super.setIsFirstTime(v);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSeenWidgetPreview(bool v) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setSeenWidgetPreview');
    try {
      return super.setSeenWidgetPreview(v);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTutorialCalled(bool v) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setTutorialCalled');
    try {
      return super.setTutorialCalled(v);
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
  void setContextMenuPos(double d) {
    final _$actionInfo = _$_PreferencesStoreActionController.startAction(
        name: '_PreferencesStore.setContextMenuPos');
    try {
      return super.setContextMenuPos(d);
    } finally {
      _$_PreferencesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
language: ${language},
isFirstTime: ${isFirstTime},
confettiController: ${confettiController},
seenWidgetPreview: ${seenWidgetPreview},
tutorialCalled: ${tutorialCalled},
tutorialBannerController: ${tutorialBannerController},
disabledPermissions: ${disabledPermissions},
actionController: ${actionController},
isConnected: ${isConnected},
biometricsEnabled: ${biometricsEnabled},
controller: ${controller},
scrollController: ${scrollController},
overlayController: ${overlayController},
overlayText: ${overlayText},
aboutContextMenuController: ${aboutContextMenuController},
contextMenuPos: ${contextMenuPos}
    ''';
  }
}
