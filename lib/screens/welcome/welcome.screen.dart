import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/welcome/local_widgets/auth_button.welcome.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_action_banner/mutable_action_banner.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
    return MutableScaffold(
      overlays: [
        ...core.utils.flows.auth.widgets,
        MutableActionBanner(
          controller: core.state.auth.actionController,
        ),
      ],
      body: Column(
        children: [
          Spacer(flex: 3),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/button.svg",
                      height: 55,
                      width: 55,
                    ),
                    SizedBox(width: 10),
                    MutableText(
                      "Safe",
                      size: 34,
                      weight: TypeWeight.heavy,
                    ),
                  ],
                ),
                SizedBox(
                  height: 38,
                ),
                AuthButton(AuthType.signup),
                SizedBox(height: 16),
                AuthButton(AuthType.login),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 10,
            child: Opacity(
              opacity: 0.78,
              child: RiveAnimation.asset(
                "assets/animations/bubbles.riv",
                alignment: Alignment.bottomCenter,
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
