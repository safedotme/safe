import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class PlayScreen extends StatefulWidget {
  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      isDismissable: true,
      isOpen: true, // TODO: Change me
      onOpen: () {},
      onClose: () {},
      controller: core.state.incident.playController,
      body: Container(
        color: Colors.red,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.landscapeRight]);
            },
            child: MutableText("Click me"),
          ),
        ),
      ),
    );
  }
}
