import 'package:mobx/mobx.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_permission_card/mutable_permission_card.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'signup.store.g.dart';

class SignupStore extends _SignupStore with _$SignupStore {}

abstract class _SignupStore with Store {
  // BANNER RELATED

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
  Map<PermissionType, Map> permissionsErrors = {};

  @action
  void addPermissionsError(PermissionType type, Map response) =>
      !permissionsErrors.containsKey(type)
          ? permissionsErrors[type] = response
          : null;

  @action
  void removePermissionsError(PermissionType type) =>
      permissionsErrors.remove(type);

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
  String countryDialCode = "+1";

  @observable
  String countryCode = "US";

  @action
  void setCountryDialCode(String v) => countryDialCode = v;

  @action
  void setPhoneNumber(String v) => phoneNumber = v;

  @action
  void setCountryCode(String v) => countryCode = v;

  @observable
  Function? onPick;

  @action
  void setOnPick(Function fn) => onPick = fn;
}
