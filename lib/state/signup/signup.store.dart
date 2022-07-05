import 'package:mobx/mobx.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'signup.store.g.dart';

class SignupStore extends _SignupStore with _$SignupStore {}

abstract class _SignupStore with Store {
  @observable
  PanelController nameInputController = PanelController();
}
