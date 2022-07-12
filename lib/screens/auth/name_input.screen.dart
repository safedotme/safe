import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'dart:math';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_input_panel/mutable_input_panel.widget.dart';
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
  late TextEditingController fieldController;
  FocusNode node = FocusNode();
  late String hintName;
  bool error = false;

  // Animation stuff
  double topMargin = kTopMargin;
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
    hintName = generateRandomName();

    // Sync forward & reverse functionality with banner
    core.state.signup.setOnBannerForward(() {
      controller.forward();
    });
    core.state.signup.setOnBannerReverse(() {
      controller.reverse();
    });

    // Initialize controller to remove special characters or numbers from name
    fieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
    node.dispose();
  }

  void submit() async {
    bool error = false;

    // Check for name
    if (core.state.signup.name.isEmpty) {
      error = true;

      core.state.signup.setBannerState(MessageType.error);
      core.state.signup.setBannerTitle(
        core.utils.language.langMap[core.state.preferences.language]!["auth"]
            ["name_input"]["error-emptyField/title"],
      );
      core.state.signup.setBannerMessage(
        core.utils.language.langMap[core.state.preferences.language]!["auth"]
            ["name_input"]["error-emptyField/desc"],
      );
      core.state.signup.bannerController.show();
    }

    if (!core.state.signup.name.contains(" ") && !error) {
      error = true;
      core.state.signup.setBannerState(MessageType.error);
      core.state.signup.setBannerTitle(
        core.utils.language.langMap[core.state.preferences.language]!["auth"]
            ["name_input"]["error-lastName/title"],
      );
      core.state.signup.setBannerMessage(
        core.utils.language.langMap[core.state.preferences.language]!["auth"]
            ["name_input"]["error-lastName/desc"],
      );
      core.state.signup.bannerController.show();
    }

    core.state.signup.setNameError(error);

    if (!error) {
      // Navigate

      core.utils.popupNavigation.navigate(
        null,
        core.state.signup.nameInputController,
        core.state.signup.permissionsController,
        controller,
      );
    } else {
      node.nextFocus();
    }
  }

  void handleInput(String? name) {
    if (name == null) {
      return;
    }

    // Purify name
    String noSym = core.utils.text.removeSymbols(name);
    String noNum = core.utils.text.removeNumbers(noSym);

    fieldController.text = noNum;
    // Sets cursor position to end
    fieldController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: fieldController.text.length,
      ),
    );

    core.state.signup.setName(noNum);
  }

  String generateRandomName() {
    List<String> names =
        core.utils.language.langMap[core.state.preferences.language]!["auth"]
            ["name_input"]["hintNames"];

    return names[Random().nextInt(names.length)];
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - topMargin,
      controller: core.state.signup.nameInputController,
      onClosed: () {
        node.unfocus();
        core.state.signup.bannerController.dismiss();
      },
      body: Observer(
        builder: (_) => MutableInputPanel(
          body: MutableTextField(
            controller: fieldController,
            type: TextInputType.name,
            focusNode: node,
            onChange: handleInput,
            onSubmit: (_) {
              submit();
            },
            hintText: hintName,
          ),
          resizeToAvoidBottomInsets: true,
          title: core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["name_input"]["title"],
          description: core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["name_input"]["desc"],
          icon: MutableIcons.profile,
          isActive: !core.state.signup.nameError,
          onTap: submit,
          buttonText: core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["name_input"]["buttonText"],
        ),
      ),
    );
  }
}
