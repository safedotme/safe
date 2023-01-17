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
  String toString() {
    return '''
language: ${language},
disabledPermissions: ${disabledPermissions},
actionController: ${actionController},
isConnected: ${isConnected}
    ''';
  }
}
