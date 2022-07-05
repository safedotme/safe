import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_icon_sphere/mutable_icon_sphere.widget.dart';
import 'package:safe/widgets/mutable_input_panel/mutable_input_panel.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class NameInputScreen extends StatefulWidget {
  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  late Core core;
  late MediaQueryData queryData;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - 42,
      controller: core.state.signup.nameInputController,
      body: MutableInputPanel(
        body: Container(),
        title: "What should we call you?",
        description:
            "Please provide your full real name. It's\nimportant for others to identify you.",
        icon: Icons.ac_unit_rounded,
      ),
    );
  }
}
