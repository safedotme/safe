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
  String toString() {
    return '''
controller: ${controller},
hintTextController: ${hintTextController},
camera: ${camera},
cameras: ${cameras},
isCameraInitialized: ${isCameraInitialized}
    ''';
  }
}
