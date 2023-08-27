import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/user/user.model.dart';

class EraseServer {
  static Future<bool> eraseUserContents(Core core) async {
    // Fetch & delete incidents
    List<Incident> incidents = core.state.incidentLog.incidents ?? [];

    for (Incident i in incidents) {
      await core.services.server.incidents.delete(i.id);
    }

    // Fetch  & delete contacts
    List<Contact> contacts = core.state.contact.contacts ?? [];

    for (Contact c in contacts) {
      await core.services.server.contacts.delete(c.id);
    }

    // Erase user
    String? id = core.services.auth.currentUser?.uid;

    if (id == null) return false;

    User? user = await core.services.server.user.readFromIdOnce(id: id);

    if (user == null) return false;

    user = user.copyWith(
      name: "",
      phone: "",
    );

    await core.services.server.user.upsert(user);

    return true;
  }
}
