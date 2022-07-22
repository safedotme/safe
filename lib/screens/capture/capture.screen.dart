import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_tranistion.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class Capture extends StatefulWidget {
  @override
  State<Capture> createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      controller: core.state.capture.controller,
      body: Container(
        color: kColorMap[MutableColor.neutral10],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                core.state.capture.controller.open();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MutableText(
                  "Open",
                  style: TypeStyle.h2,
                  size: 30,
                ),
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                core.state.capture.controller.close();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MutableText(
                  "Close",
                  style: TypeStyle.h2,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
