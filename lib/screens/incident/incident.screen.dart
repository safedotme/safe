import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident/local_widgets/incident_header_box.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';

class IncidentScreen extends StatefulWidget {
  @override
  State<IncidentScreen> createState() => _IncidentInstanState();
}

class _IncidentInstanState extends State<IncidentScreen> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      isOpen: true,
      isDismissable: false,
      controller: core.state.incident.controller,
      body: Container(
        color: kColorMap[MutableColor.neutral10],
        child: SingleChildScrollView(
          child: Column(
            children: [IncidentHeaderBox()],
          ),
        ),
      ),
    );
  }
}
