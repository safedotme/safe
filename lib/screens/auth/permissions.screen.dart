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
  List<PermissionType> permissions = MutablePermissionCard.permissionList;
  bool areEnabled = true;

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
    core.state.auth.setOnBannerForward(() {
      controller.forward();
    });
    core.state.auth.setOnBannerReverse(() {
      controller.reverse();
    });
  }

  void navigate() {
    if (core.state.auth.authType == AuthType.signup) {
      core.utils.popupNavigation.navigate(
        core.state.auth.nameInputController,
        core.state.auth.permissionsController,
        core.state.auth.phoneVerificationController,
        controller,
      );

      return;
    }

    core.utils.popupNavigation.navigate(
      null,
      core.state.auth.permissionsController,
      core.state.auth.phoneVerificationController,
      controller,
    );
  }

  void submit() {
    setState(() {
      areEnabled = core.utils.permissions.checkPermissions(
        core,
        sendError: true,
      );
    });

    if (areEnabled) {
      navigate();
    }
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - topMargin,
      controller: core.state.auth.permissionsController,
      onClosed: () {
        core.state.auth.bannerController.dismiss();

        if (core.state.auth.authType == AuthType.signup) {
          core.state.auth.nameInputController.open();
        }
      },
      body: Observer(
        builder: (_) {
          // checkPermissions(Duration.zero);
          return MutableInputPanel(
            // Permission Cards
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // Lays out the permission cards
              children: List.generate(
                permissions.length,
                (i) => Padding(
                  padding: EdgeInsets.only(
                    bottom: i + 1 == permissions.length ? 0 : 12,
                  ),
                  child: MutablePermissionCard(
                    type: MutablePermissionCard.permissionList[i],
                    navigate: navigate,
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
            isActive: areEnabled, // Refactor
            buttonText: core.utils.language
                    .langMap[core.state.preferences.language]!["auth"]
                ["permissions"]["buttonText"], // "Next"
          );
        },
      ),
    );
  }
}
