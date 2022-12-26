import 'package:safe/models/incident/notified_contact.model.dart';

class ContactsUtil {
  static List<NotifiedContact>? formatContactList(List<NotifiedContact>? raw) {
    if (raw == null) return null;
    List<String> phones = [];
    List<NotifiedContact> contacts = [];

    for (int i = 0; i < raw.length; i++) {
      phones.add(raw[i].phone);
    }

    phones = phones.toSet().toList();

    for (String phone in phones) {
      NotifiedContact cont =
          raw.firstWhere((element) => element.phone == phone);

      if (!contacts.contains(cont)) {
        contacts.add(cont);
      }
    }

    return contacts;
  }
}
