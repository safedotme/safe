import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_input_panel/mutable_input_panel.widget.dart';
import 'package:safe/widgets/mutable_permission_card/mutable_permission_card.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';

class PermissionsScreen extends StatefulWidget {
  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen>
    with TickerProviderStateMixin {
  late Core core;
  late MediaQueryData queryData;
  late AnimationController controller;
  bool error = false;
  List<PermissionType> permissions = MutablePermissionCard.permissionList;

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

    controller.dispose();
  }

  void submit() {
    bool error = false;
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - topMargin,
      controller: core.state.signup.permissionsController,
      onClosed: () {
        core.state.signup.bannerController.dismiss();
        core.state.signup.nameInputController.open();
      },
      body: Observer(
        builder: (_) => MutableInputPanel(
          // Permission Cards
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              permissions.length,
              (i) => Padding(
                padding: EdgeInsets.only(
                  bottom: i + 1 == permissions.length ? 0 : 12,
                ),
                child: MutablePermissionCard(
                  type: MutablePermissionCard.permissionList[i],
                ),
              ),
            ),
          ),

          // Display stuff
          title: core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["title"], // "Enable Permissions"
          description: core.utils.language
                      .langMap[core.state.preferences.language]!["auth"]
                  ["permissions"]
              ["desc"], // "Before getting started, we'll need..."
          icon: MutableIcons.key,
          onTap: submit,
          buttonText: core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["buttonText"], // "Next"
        ),
      ),
    );
  }
}