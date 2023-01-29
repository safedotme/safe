import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_message_page/mutable_message_page.widget.dart';

class IncidentNotFoundPage extends StatefulWidget {
  @override
  State<IncidentNotFoundPage> createState() => _IncidentNotFoundPageState();
}

class _IncidentNotFoundPageState extends State<IncidentNotFoundPage> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableMessagePage(
        type: core.state.play.isCompleted
            ? MessageType.success
            : MessageType.error,
        header: core.state.play.isCompleted
            ? "The Incident has Ended"
            : "Error Loading Incident",
        description: core.state.play.isCompleted
            ? "The user has ended the incident. As an emergency contact, you will shortly receive an SMS message the user's final information."
            : "This incident does not exist. This is most likely due to ID next to the URL. Check the ID (live.joinsafe.me/{id}) is valid.",
      ),
    );
  }
}
