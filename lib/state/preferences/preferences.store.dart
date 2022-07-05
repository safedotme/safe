import 'package:mobx/mobx.dart';
import 'package:safe/utils/language/language.util.dart';

part 'preferences.store.g.dart';

class PreferencesStore extends _PreferencesStore with _$PreferencesStore {}

abstract class _PreferencesStore with Store {
  @observable
  Languages language = Languages.english;

  @action
  void setLanguage(Languages l) => language = l;
}
