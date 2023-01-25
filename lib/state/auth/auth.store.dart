import 'package:mobx/mobx.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_action_banner/mutable_action_banner.widget.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';
import 'package:safe/widgets/mutable_permission_card/mutable_permission_card.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'auth.store.g.dart';

class AuthStore extends _AuthStore with _$AuthStore {}

abstract class _AuthStore with Store {
  // GENERAL
  @observable
  AuthType authType = AuthType.signup;

  @action
  void setAuthType(AuthType t) => authType = t;

  // BANNER RELATED
  @observable
  ActionBannerController actionController = ActionBannerController();

  @observable
  BannerController bannerController = BannerController();

  @observable
  MessageType bannerState = MessageType.success;

  @action
  void setBannerState(MessageType t) => bannerState = t;

  @observable
  String bannerTitle = "";

  @action
  void setBannerTitle(String t) => bannerTitle = t;

  @observable
  String bannerMessage = "";

  @action
  void setBannerMessage(String m) => bannerMessage = m;

  @observable
  void Function() onBannerTap = () {};

  @action
  void setOnBannerTap(void Function() function) => onBannerTap = function;

  @observable
  List<void Function()> onBannerForward = [];

  @action
  void setOnBannerForward(void Function() function) =>
      onBannerForward.add(function);

  @observable
  List<void Function()> onBannerReverse = [];

  @action
  void setOnBannerReverse(void Function() function) =>
      onBannerReverse.add(function);

  @observable
  Duration delay = Duration(seconds: 3);

  @action
  void setDelay(Duration d) => delay = d;

  // NAME

  @observable
  String name = "";

  @action
  void setName(String _) => name = _;

  @observable
  PanelController nameInputController = PanelController();

  @observable
  bool nameError = false;

  @action
  void setNameError(bool v) => nameError = v;

  // PERMISSIONS

  @observable
  PanelController permissionsController = PanelController();

  @observable
  Map<PermissionType, PermissionData> permissionMap = {};

  @action
  void setPermission(PermissionType type, PermissionData data) =>
      permissionMap[type] = data;

  // PHONE VERIFICATION

  @observable
  PanelController phoneVerificationController = PanelController();

  @observable
  PanelController countryCodeController = PanelController();

  @observable
  PanelController otpInputPanelController = PanelController();

  @observable
  String phoneNumber = "";

  @observable
  String formattedPhone = "";

  @observable
  String countryDialCode = "+1";

  @observable
  String countryCode = "US";

  @action
  void setCountryDialCode(String v) => countryDialCode = v;

  @action
  void setPhoneNumber(String v) => phoneNumber = v;

  @action
  void setFormattedPhone(String v) => formattedPhone = v;

  @action
  void setCountryCode(String v) => countryCode = v;

  @observable
  Function? onPick;

  @action
  void setOnPick(Function fn) => onPick = fn;

  @observable
  String verificationId = "";

  @observable
  int? resendToken;

  @action
  void setVerificationId(String id) => verificationId = id;

  @action
  void setResendToken(int? token) => resendToken = token;

  // OVERLAY
  @observable
  OverlayController overlayController = OverlayController();

  @observable
  ScreenTransitionController tutorialController = ScreenTransitionController();

  @observable
  bool isTutorialOpen = false;

  @action
  void setIsTutorialOpen(bool v) => isTutorialOpen = v;
}
