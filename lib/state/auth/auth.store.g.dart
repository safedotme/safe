// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$bannerControllerAtom =
      Atom(name: '_AuthStore.bannerController', context: context);

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
      Atom(name: '_AuthStore.bannerState', context: context);

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
      Atom(name: '_AuthStore.bannerTitle', context: context);

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
      Atom(name: '_AuthStore.bannerMessage', context: context);

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
      Atom(name: '_AuthStore.onBannerTap', context: context);

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
      Atom(name: '_AuthStore.onBannerForward', context: context);

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
      Atom(name: '_AuthStore.onBannerReverse', context: context);

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

  late final _$delayAtom = Atom(name: '_AuthStore.delay', context: context);

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

  late final _$nameAtom = Atom(name: '_AuthStore.name', context: context);

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
      Atom(name: '_AuthStore.nameInputController', context: context);

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
      Atom(name: '_AuthStore.nameError', context: context);

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
      Atom(name: '_AuthStore.permissionsController', context: context);

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
      Atom(name: '_AuthStore.permissionsErrors', context: context);

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

  late final _$phoneVerificationControllerAtom =
      Atom(name: '_AuthStore.phoneVerificationController', context: context);

  @override
  PanelController get phoneVerificationController {
    _$phoneVerificationControllerAtom.reportRead();
    return super.phoneVerificationController;
  }

  @override
  set phoneVerificationController(PanelController value) {
    _$phoneVerificationControllerAtom
        .reportWrite(value, super.phoneVerificationController, () {
      super.phoneVerificationController = value;
    });
  }

  late final _$countryCodeControllerAtom =
      Atom(name: '_AuthStore.countryCodeController', context: context);

  @override
  PanelController get countryCodeController {
    _$countryCodeControllerAtom.reportRead();
    return super.countryCodeController;
  }

  @override
  set countryCodeController(PanelController value) {
    _$countryCodeControllerAtom.reportWrite(value, super.countryCodeController,
        () {
      super.countryCodeController = value;
    });
  }

  late final _$otpInputPanelControllerAtom =
      Atom(name: '_AuthStore.otpInputPanelController', context: context);

  @override
  PanelController get otpInputPanelController {
    _$otpInputPanelControllerAtom.reportRead();
    return super.otpInputPanelController;
  }

  @override
  set otpInputPanelController(PanelController value) {
    _$otpInputPanelControllerAtom
        .reportWrite(value, super.otpInputPanelController, () {
      super.otpInputPanelController = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: '_AuthStore.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$formattedPhoneAtom =
      Atom(name: '_AuthStore.formattedPhone', context: context);

  @override
  String get formattedPhone {
    _$formattedPhoneAtom.reportRead();
    return super.formattedPhone;
  }

  @override
  set formattedPhone(String value) {
    _$formattedPhoneAtom.reportWrite(value, super.formattedPhone, () {
      super.formattedPhone = value;
    });
  }

  late final _$countryDialCodeAtom =
      Atom(name: '_AuthStore.countryDialCode', context: context);

  @override
  String get countryDialCode {
    _$countryDialCodeAtom.reportRead();
    return super.countryDialCode;
  }

  @override
  set countryDialCode(String value) {
    _$countryDialCodeAtom.reportWrite(value, super.countryDialCode, () {
      super.countryDialCode = value;
    });
  }

  late final _$countryCodeAtom =
      Atom(name: '_AuthStore.countryCode', context: context);

  @override
  String get countryCode {
    _$countryCodeAtom.reportRead();
    return super.countryCode;
  }

  @override
  set countryCode(String value) {
    _$countryCodeAtom.reportWrite(value, super.countryCode, () {
      super.countryCode = value;
    });
  }

  late final _$onPickAtom = Atom(name: '_AuthStore.onPick', context: context);

  @override
  Function? get onPick {
    _$onPickAtom.reportRead();
    return super.onPick;
  }

  @override
  set onPick(Function? value) {
    _$onPickAtom.reportWrite(value, super.onPick, () {
      super.onPick = value;
    });
  }

  late final _$verificationIdAtom =
      Atom(name: '_AuthStore.verificationId', context: context);

  @override
  String get verificationId {
    _$verificationIdAtom.reportRead();
    return super.verificationId;
  }

  @override
  set verificationId(String value) {
    _$verificationIdAtom.reportWrite(value, super.verificationId, () {
      super.verificationId = value;
    });
  }

  late final _$resendTokenAtom =
      Atom(name: '_AuthStore.resendToken', context: context);

  @override
  int? get resendToken {
    _$resendTokenAtom.reportRead();
    return super.resendToken;
  }

  @override
  set resendToken(int? value) {
    _$resendTokenAtom.reportWrite(value, super.resendToken, () {
      super.resendToken = value;
    });
  }

  late final _$overlayControllerAtom =
      Atom(name: '_AuthStore.overlayController', context: context);

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

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  void setBannerState(MessageType t) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setBannerState');
    try {
      return super.setBannerState(t);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBannerTitle(String t) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setBannerTitle');
    try {
      return super.setBannerTitle(t);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBannerMessage(String m) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setBannerMessage');
    try {
      return super.setBannerMessage(m);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnBannerTap(void Function() function) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setOnBannerTap');
    try {
      return super.setOnBannerTap(function);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnBannerForward(void Function() function) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setOnBannerForward');
    try {
      return super.setOnBannerForward(function);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnBannerReverse(void Function() function) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setOnBannerReverse');
    try {
      return super.setOnBannerReverse(function);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDelay(Duration d) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setDelay');
    try {
      return super.setDelay(d);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String _) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setName');
    try {
      return super.setName(_);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNameError(bool v) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setNameError');
    try {
      return super.setNameError(v);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPermissionsError(
      PermissionType type, Map<dynamic, dynamic> response) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.addPermissionsError');
    try {
      return super.addPermissionsError(type, response);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePermissionsError(PermissionType type) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.removePermissionsError');
    try {
      return super.removePermissionsError(type);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCountryDialCode(String v) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setCountryDialCode');
    try {
      return super.setCountryDialCode(v);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneNumber(String v) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setPhoneNumber');
    try {
      return super.setPhoneNumber(v);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFormattedPhone(String v) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setFormattedPhone');
    try {
      return super.setFormattedPhone(v);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCountryCode(String v) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setCountryCode');
    try {
      return super.setCountryCode(v);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnPick(Function fn) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setOnPick');
    try {
      return super.setOnPick(fn);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVerificationId(String id) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setVerificationId');
    try {
      return super.setVerificationId(id);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setResendToken(int? token) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setResendToken');
    try {
      return super.setResendToken(token);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
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
permissionsErrors: ${permissionsErrors},
phoneVerificationController: ${phoneVerificationController},
countryCodeController: ${countryCodeController},
otpInputPanelController: ${otpInputPanelController},
phoneNumber: ${phoneNumber},
formattedPhone: ${formattedPhone},
countryDialCode: ${countryDialCode},
countryCode: ${countryCode},
onPick: ${onPick},
verificationId: ${verificationId},
resendToken: ${resendToken},
overlayController: ${overlayController}
    ''';
  }
}
