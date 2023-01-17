import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe/utils/language/language.util.dart';
import 'package:safe/widgets/mutable_action_banner/mutable_action_banner.widget.dart';

part 'preferences.store.g.dart';

class PreferencesStore extends _PreferencesStore with _$PreferencesStore {}

abstract class _PreferencesStore with Store {
  @observable
  Languages language = Languages.english;

  @action
  void setLanguage(Languages l) => language = l;

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
}
