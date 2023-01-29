import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_page/mutable_page.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class PlayPage extends StatefulWidget {
  final String? incidentId;

  PlayPage(this.incidentId);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    initServer();
    subscribe();
  }

  void initServer() => core.services.server.init();

  void subscribe() {
    //4fc6c55596cb441eba254d8df9c19f32 TODO: Remove

    final stream = core.services.server.incidents.read(
      "4fc6c55596cb441eba254d8df9c19f32",
    );
  }

  @override
  Widget build(BuildContext context) {
    return MutablePage(
        body: Center(
      child: MutableText(
        widget.incidentId ?? "404",
      ),
    ));
  }
}
