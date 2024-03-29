import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/language/language.util.dart';
import 'package:safe/widgets/mutable_action_banner/mutable_action_banner.widget.dart';
import 'package:safe/widgets/mutable_context_menu/mutable_context_menu.widget.dart'
    as custom;
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'preferences.store.g.dart';

class PreferencesStore extends _PreferencesStore with _$PreferencesStore {}

abstract class _PreferencesStore with Store {
  @observable
  Languages language = Languages.english;

  @action
  void setLanguage(Languages l) => language = l;

  @observable
  bool isFirstTime = false;

  @action
  void setIsFirstTime(bool v) => isFirstTime = v;

  @observable
  ConfettiController confettiController = ConfettiController(
    duration: kConfettiDuration,
  );

  @observable
  bool seenWidgetPreview = false;

  @action
  void setSeenWidgetPreview(bool v) => seenWidgetPreview = v;

  @observable
  bool tutorialCalled = false;

  @action
  void setTutorialCalled(bool v) => tutorialCalled = v;

  @observable
  PanelController tutorialBannerController = PanelController();

  @observable
  List<Permission> disabledPermissions = [];

  @action
  void setDisabledPermissions(List<Permission> p) => disabledPermissions = p;

  @observable
  ActionBannerController actionController = ActionBannerController();

  @observable
  bool isConnected = true;

  @action
  void setIsConnected(bool b) => isConnected = b;

  @observable
  bool? biometricsEnabled;

  @action
  void setBiometricsEnabled(bool? v) => biometricsEnabled = v;

  // SETTINGS RELATED
  @observable
  ScreenTransitionController controller = ScreenTransitionController();

  @observable
  ScrollController scrollController = ScrollController();

  @observable
  OverlayController overlayController = OverlayController();

  @observable
  String overlayText = "";

  @action
  void setOverlayText(String s) => overlayText = s;

  @observable
  custom.ContextMenuController aboutContextMenuController =
      custom.ContextMenuController();

  @observable
  double contextMenuPos = 0;

  @action
  void setContextMenuPos(double d) => contextMenuPos = d;
}
