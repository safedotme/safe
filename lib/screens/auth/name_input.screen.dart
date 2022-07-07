import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_input_panel/mutable_input_panel.widget.dart';
import 'package:safe/widgets/mutable_large_button/mutable_large_button.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text_field/mutable_text_field.widget.dart';

class NameInputScreen extends StatefulWidget {
  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen>
    with TickerProviderStateMixin {
  late Core core;
  late MediaQueryData queryData;
  late AnimationController controller;

  // Animation stuff
  double topMargin = 42;
  void initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: kMutableBannerDuration,
    );

    // Initialize tween
    Animation tween =
        Tween<double>(begin: 42, end: kMutableBannerHeight + 20).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    controller.addListener(() {
      setState(() {
        topMargin = tween.value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    initializeAnimation();

    // Sync forward & reverse functionality with banner
    core.state.signup.setOnBannerForward(() {
      controller.forward();
    });
    core.state.signup.setOnBannerReverse(() {
      controller.reverse();
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - topMargin,
      controller: core.state.signup.nameInputController,
      onClosed: () {
        core.state.signup.bannerController.dismiss();
      },
      body: MutableInputPanel(
        body: MutableTextField(
          onChange: (_) {
            print(_);
          },
          hintText: "Barney Stinson",
        ),
        title: "What should we call you?",
        description:
            "Please provide your full real name. It's\nimportant for others to identify you.",
        icon: MutableIcons.profile,
        buttonState: ButtonState.active,
        onTap: () async {
          core.state.signup.bannerController.show();
        },
        buttonText: "Next",
      ),
    );
  }
}
