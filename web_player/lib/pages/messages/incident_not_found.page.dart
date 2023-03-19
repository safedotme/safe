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
        type: MessageType.success,
        header: "The Incident has Ended",
        description:
            "The user has ended the incident. As an emergency contact, you will shortly receive an SMS message with a summary of the incident.",
      ),
    );
  }
}
