import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_message_page/mutable_message_page.widget.dart';

class IncidentNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MutableMessagePage(
      type: MessageType.error,
      header: "Error Loading Incident",
      description:
          "This incident does not exist. This is most likely due to ID next to the URL. Check the ID (live.joinsafe.me/{id}) is valid.",
    );
  }
}
