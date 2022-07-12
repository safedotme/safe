import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_input_panel/mutable_input_panel.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
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
  late TextEditingController fieldController;
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

    // Initialize text editing controller for auto phone format
    fieldController = TextEditingController();
    core.state.signup.setOnPick(format);
  }

  @override
  void dispose() {
    super.dispose();

    node.dispose();
    controller.dispose();
  }

  // Generates different hint text based on country
  String handleHint(String code) {
    return code == "US" ? "(999) 999-9999" : "9999 9999";
  }

  void submit() async {
    // POSSIBLY CHANGE BASED ON ERR
    core.state.signup.countryCodeController.close();
    node.unfocus();
  }

  void format(String? phone) async {
    // REFORMAT WHEN COUNTRY CODE CHANGES
    if (phone != null) {
      // Removes all symbols from fieldController value
      String pure = core.utils.text.removeSymbols(phone);

      fieldController.text = await core.utils.phone.format(
        pure,
        core.state.signup.countryCode,
      );

      // Sets cursor position to end
      fieldController.selection = TextSelection.fromPosition(
        TextPosition(
          offset: fieldController.text.length,
        ),
      );

      core.state.signup.setPhoneNumber(pure);
    }
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
        // Phone Input Text Field
        body: Observer(
          builder: (_) => MutableTextField(
            controller: fieldController,
            type: TextInputType.phone,
            focusNode: node,
            onChange: format,
            hintText: handleHint(core.state.signup.countryCode),
            leadingLeft: Observer(
              builder: (_) => PhoneExtentionDisplay(
                core.state.signup.countryDialCode,
                onTap: () {
                  node.unfocus();
                  core.state.signup.countryCodeController.open();
                },
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInsets: true,
        // Display related properties
        title: core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["phone_verification"]["title"], // "Enter Phone Number"
        description: core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["phone_verification"]["desc"], // "We'll send you..."
        icon: MutableIcons.phone,
        // Size is custom due to SVG specifications
        iconSize: Size(26, 26), // Extract
        onTap: submit,
        isActive: true,
        buttonText: core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["phone_verification"]["buttonText"], // "Send Link"
      ),
    );
  }
}
