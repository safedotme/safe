// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupStore on _SignupStore, Store {
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

  late final _$onTapAtom = Atom(name: '_SignupStore.onTap', context: context);

  @override
  void Function() get onTap {
    _$onTapAtom.reportRead();
    return super.onTap;
  }

  @override
  set onTap(void Function() value) {
    _$onTapAtom.reportWrite(value, super.onTap, () {
      super.onTap = value;
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
  void setOnTap(void Function() function) {
    final _$actionInfo = _$_SignupStoreActionController.startAction(
        name: '_SignupStore.setOnTap');
    try {
      return super.setOnTap(function);
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
  String toString() {
    return '''
nameInputController: ${nameInputController},
bannerController: ${bannerController},
bannerState: ${bannerState},
bannerTitle: ${bannerTitle},
bannerMessage: ${bannerMessage},
onTap: ${onTap},
delay: ${delay}
    ''';
  }
}
