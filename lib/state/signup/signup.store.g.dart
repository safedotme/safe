// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupStore on _SignupStore, Store {
  late final _$bannerControllerAtom =
      Atom(name: '_SignupStore.bannerController', context: context);

  @override
  BannerController get bannerController {
    _$bannerControllerAtom.reportRead();
    return super.bannerController;
  }

  @override
  set bannerController(BannerController value) {
    _$bannerControllerAtom.reportWrite(value, super.bannerController, () {
      super.bannerController = value;
    });
  }

  late final _$bannerStateAtom =
      Atom(name: '_SignupStore.bannerState', context: context);

  @override
  MessageType get bannerState {
    _$bannerStateAtom.reportRead();
    return super.bannerState;
  }

  @override
  set bannerState(MessageType value) {
    _$bannerStateAtom.reportWrite(value, super.bannerState, () {
      super.bannerState = value;
    });
  }

  late final _$bannerTitleAtom =
      Atom(name: '_SignupStore.bannerTitle', context: context);

  @override
  String get bannerTitle {
    _$bannerTitleAtom.reportRead();
    return super.bannerTitle;
  }

  @override
  set bannerTitle(String value) {
    _$bannerTitleAtom.reportWrite(value, super.bannerTitle, () {
      super.bannerTitle = value;
    });
  }

  late final _$bannerMessageAtom =
      Atom(name: '_SignupStore.bannerMessage', context: context);

  @override
  String get bannerMessage {
    _$bannerMessageAtom.reportRead();
    return super.bannerMessage;
  }

  @override
  set bannerMessage(String value) {
    _$bannerMessageAtom.reportWrite(value, super.bannerMessage, () {
      super.bannerMessage = value;
    });
  }

  late final _$onBannerTapAtom =
      Atom(name: '_SignupStore.onBannerTap', context: context);

  @override
  void Function() get onBannerTap {
    _$onBannerTapAtom.reportRead();
    return super.onBannerTap;
  }

  @override
  set onBannerTap(void Function() value) {
    _$onBannerTapAtom.reportWrite(value, super.onBannerTap, () {
      super.onBannerTap = value;
    });
  }

  late final _$onBannerForwardAtom =
      Atom(name: '_SignupStore.onBannerForward', context: context);

  @override
  List<void Function()> get onBannerForward {
    _$onBannerForwardAtom.reportRead();
    return super.onBannerForward;
  }

  @override
  set onBannerForward(List<void Function()> value) {
    _$onBannerForwardAtom.reportWrite(value, super.onBannerForward, () {
      super.onBannerForward = value;
    });
  }

  late final _$onBannerReverseAtom =
      Atom(name: '_SignupStore.onBannerReverse', context: context);

  @override
  List<void Function()> get onBannerReverse {
    _$onBannerReverseAtom.reportRead();
    return super.onBannerReverse;
  }

  @override
  set onBannerReverse(List<void Function()> value) {
    _$onBannerReverseAtom.reportWrite(value, super.onBannerReverse, () {
      super.onBannerReverse = value;
    });
  }

  late final _$delayAtom = Atom(name: '_SignupStore.delay', context: context);

  @override
  Duration get delay {
    _$delayAtom.reportRead();
    return super.delay;
  }

  @override
  set delay(Duration value) {
    _$delayAtom.reportWrite(value, super.delay, () {
      super.delay = value;
    });
  }

  late final _$nameAtom = Atom(name: '_SignupStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$nameInputControllerAtom =
      Atom(name: '_SignupStore.nameInputController', context: context);

  @override
  PanelController get nameInputController {
    _$nameInputControllerAtom.reportRead();
    return super.nameInputController;
  }

  @override
  set nameInputController(PanelController value) {
    _$nameInputControllerAtom.reportWrite(value, super.nameInputController, () {
      super.nameInputController = value;
    });
  }

  late final _$nameErrorAtom =
      Atom(name: '_SignupStore.nameError', context: context);

  @override
  bool get nameError {
    _$nameErrorAtom.reportRead();
    return super.nameError;
  }

  @override
  set nameError(bool value) {
    _$nameErrorAtom.reportWrite(value, super.nameError, () {
      super.nameError = value;
    });
  }

  late final _$permissionsControllerAtom =
      Atom(name: '_SignupStore.permissionsController', context: context);

  @override
  PanelController get permissionsController {
    _$permissionsControllerAtom.reportRead();
    return super.permissionsController;
  }

  @override
  set permissionsController(PanelController value) {
    _$permissionsControllerAtom.reportWrite(value, super.permissionsController,
        () {
      super.permissionsController = value;
    });
  }

  late final _$permissionsErrorsAtom =
      Atom(name: '_SignupStore.permissionsErrors', context: context);

  @override
  Map<PermissionType, Map<dynamic, dynamic>> get permissionsErrors {
    _$permissionsErrorsAtom.reportRead();
    return super.permissionsErrors;
  }

  @override
  set permissionsErrors(Map<PermissionType, Map<dynamic, dynamic>> value) {
    _$permissionsErrorsAtom.reportWrite(value, super.permissionsErrors, () {
      super.permissionsErrors = value;
    });
  }

  late final _$_SignupStoreActionController =
      ActionController(name: '_SignupStore', context: context);

  @override
  void setBannerState(MessageType t) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setBannerState');
    try {
      return super.setBannerState(t);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBannerTitle(String t) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setBannerTitle');
    try {
      return super.setBannerTitle(t);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBannerMessage(String m) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setBannerMessage');
    try {
      return super.setBannerMessage(m);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnBannerTap(void Function() function) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setOnBannerTap');
    try {
      return super.setOnBannerTap(function);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnBannerForward(void Function() function) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setOnBannerForward');
    try {
      return super.setOnBannerForward(function);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnBannerReverse(void Function() function) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setOnBannerReverse');
    try {
      return super.setOnBannerReverse(function);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDelay(Duration d) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setDelay');
    try {
      return super.setDelay(d);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String _) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setName');
    try {
      return super.setName(_);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNameError(bool v) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setNameError');
    try {
      return super.setNameError(v);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPermissionsError(
      PermissionType type, Map<dynamic, dynamic> response) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.addPermissionsError');
    try {
      return super.addPermissionsError(type, response);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePermissionsError(PermissionType type) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.removePermissionsError');
    try {
      return super.removePermissionsError(type);
    } finally {
      _$_SignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bannerController: ${bannerController},
bannerState: ${bannerState},
bannerTitle: ${bannerTitle},
bannerMessage: ${bannerMessage},
onBannerTap: ${onBannerTap},
onBannerForward: ${onBannerForward},
onBannerReverse: ${onBannerReverse},
delay: ${delay},
name: ${name},
nameInputController: ${nameInputController},
nameError: ${nameError},
permissionsController: ${permissionsController},
permissionsErrors: ${permissionsErrors}
    ''';
  }
}
