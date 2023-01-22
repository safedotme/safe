import 'package:mobx/mobx.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/local_widgets/emergency_contact_popup_header.widget.dart';
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

  @observable
  PanelController controller = PanelController();

  @observable
  PanelController editorController = PanelController();

  @observable
  EmergencyContactPopupController editorContactController =
      EmergencyContactPopupController();

  @observable
  Contact? editable;

  @action
  void setEditable(Contact c) => editable = c;

  @observable
  PanelController countryCodeSelectorController = PanelController();

  @observable
  bool isAdding = false;

  @action
  void setIsAdding(bool v) => isAdding = v;

  @observable
  PanelController importContactPopupController = PanelController();
}
