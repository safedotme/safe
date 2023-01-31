import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_input_panel/mutable_input_panel.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_submit_textfield_button/mutable_submit_textfield_button.widget.dart';
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
  bool dismissDetector = false;

  // Animation stuff
  double? topMargin;
  void initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: kMutableBannerDuration,
    );

    // Initialize tween
    Animation tween =
        Tween<double>(begin: topMargin, end: kMutableBannerHeight + 20).animate(
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

    hintName =
        core.utils.language.langMap[core.state.preferences.language]!["auth"]
            ["name_input"]["hintName"];

    // Sync forward & reverse functionality with banner
    core.state.auth.setOnBannerForward(() {
      controller.forward();
    });
    core.state.auth.setOnBannerReverse(() {
      controller.reverse();
    });

    // Initialize controller to remove special characters or numbers from name
    fieldController = TextEditingController();

    // Enables user to drag or tap to dismiss keyboard when enabled
    node.addListener(() {
      setState(() {
        dismissDetector = node.hasFocus;
      });
    });
  }

  void submit() async {
    bool error = false;

    // Check if there is a name
    final res = core.utils.name.validateName(core.state.auth.name);

    if (res["error"]) {
      error = true;

      core.state.auth.setBannerState(MessageType.error);
      core.state.auth.setBannerTitle(
        core.utils.language.langMap[core.state.preferences.language]!["auth"]
            ["name_input"]["${res["reason"]}/title"],
      );
      core.state.auth.setBannerMessage(
        core.utils.language.langMap[core.state.preferences.language]!["auth"]
            ["name_input"]["${res["reason"]}/desc"],
      );
      core.state.auth.bannerController.show();
    }

    core.state.auth.setNameError(error);

    if (!error) {
      node.unfocus();
      // Navigate
      bool hasPermissions = core.services.permissions.checkPermissions(
        core,
        sendError: false,
      );

      core.utils.popupNavigation.navigate(
        null,
        core.state.auth.nameInputController,
        hasPermissions
            ? core.state.auth.phoneVerificationController
            : core.state.auth.permissionsController,
        controller,
      );
    } else if (!node.hasFocus) {
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

    // Called after fieldController functions to not show user capitalized format
    String capitalized = core.utils.text.toTitle(noNum);

    if (capitalized.isNotEmpty && capitalized.contains(" ")) {
      core.state.auth.setNameError(false);
    }

    core.state.auth.setName(capitalized);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    if (topMargin == null) {
      topMargin = queryData.padding.top;
      initializeAnimation();
    }

    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - topMargin!,
      controller: core.state.auth.nameInputController,
      onFreezeInteraction: dismissDetector
          ? () {
              node.unfocus();
            }
          : null,
      onClosed: () {
        node.unfocus();
        core.state.auth.bannerController.dismiss();
      },
      body: Observer(
        builder: (_) => MutableInputPanel(
          body: MutableTextField(
            hints: [AutofillHints.name],
            controller: fieldController,
            leadingRight: MutableSubmitTextFieldButton(submit),
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
          isActive: !core.state.auth.nameError,
          onTap: submit,
          buttonText: core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["name_input"]["buttonText"],
        ),
      ),
    );
  }
}
