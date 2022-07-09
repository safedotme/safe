import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_input_panel/mutable_input_panel.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:safe/widgets/mutable_text_field/local_widgets/phone_extention_display.widget.dart';
import 'package:safe/widgets/mutable_text_field/mutable_text_field.widget.dart';

class PhoneVerificationScreen extends StatefulWidget {
  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen>
    with TickerProviderStateMixin {
  late Core core;
  late MediaQueryData queryData;
  late AnimationController controller;
  bool error = false;
  FocusNode node = FocusNode();

  // Animation stuff
  double topMargin = kTopMargin;
  void initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: kMutableBannerDuration,
    );

    // Initialize tween
    Animation tween =
        Tween<double>(begin: kTopMargin, end: kMutableBannerHeight + 20)
            // 20 is the margin between the banner and the popup
            .animate(
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

    node.dispose();
    controller.dispose();
  }

  void submit() {
    // POSSIBLY CHANGE BASED ON ERR
    core.state.signup.countryCodeController.close();
    node.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - topMargin,
      controller: core.state.signup.phoneVerificationController,
      onClosed: () {
        core.state.signup.countryCodeController.close();
        node.unfocus();
        core.state.signup.bannerController.dismiss();
        core.state.signup.permissionsController.open();
      },
      body: MutableInputPanel(
        // Permission Cards
        body: MutableTextField(
          type: TextInputType.phone,
          focusNode: node,
          onChange: (phone) {},
          onSubmit: (_) {
            submit();
          },
          hintText: "9999-9999",
          leadingLeft: PhoneExtentionDisplay(
            onTap: () {
              node.unfocus();
              core.state.signup.countryCodeController.open();
            },
          ),
        ),
        resizeToAvoidBottomInsets: true,
        // Display stuff
        title: "Enter Phone Number",
        description: "We'll send you a magic link to verify your\n account",
        icon: MutableIcons.phone,
        iconSize: Size(26, 26),
        onTap: submit,
        isActive: true,
        buttonText: "Send Link", // "Next"
      ),
    );
  }
}
