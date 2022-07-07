import 'package:mobx/mobx.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'signup.store.g.dart';

class SignupStore extends _SignupStore with _$SignupStore {}

abstract class _SignupStore with Store {
  @observable
  PanelController nameInputController = PanelController();

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
  void Function() onTap = () {};

  @action
  void setOnTap(void Function() function) => onTap = function;

  @observable
  Duration delay = Duration(seconds: 3);

  @action
  void setDelay(Duration d) => delay = d;
}
