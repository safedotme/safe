import 'package:mobx/mobx.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'contacts.store.g.dart';

class ContactStore extends _ContactStore with _$ContactStore {}

abstract class _ContactStore with Store {
  @observable
  List<Contact>? contacts;

  @action
  void setContacts(List<Contact> c) => contacts = c;

  @observable
  PanelController homeWariningController = PanelController();

  @observable
  bool isEditing = false;

  @action
  void setIsEditing(bool v) => isEditing = v;
}
