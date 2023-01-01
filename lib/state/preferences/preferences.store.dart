import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe/utils/language/language.util.dart';

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
}
