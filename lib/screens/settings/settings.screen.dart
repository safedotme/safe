import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/settings/local_widgets/settings_nav_bar.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      isOpen: true, // TODO: Set to false
      controller: core.state.preferences.controller,
      isDismissable: false,
      body: Container(
        color: kColorMap[MutableColor.neutral10],
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SettingsNavBar(),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 108),
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
