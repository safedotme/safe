import 'package:safe/models/incident/notified_contact.model.dart';

class Contacts {
  static List<NotifiedContact>? formatContactList(List<NotifiedContact>? raw) {
    if (raw == null) return null;
    List<NotifiedContact> contacts = [];

    for (NotifiedContact c in raw) {
      if (!contacts.contains(c)) {
        contacts.add(c);
      }
    }

    return contacts;
  }
}
