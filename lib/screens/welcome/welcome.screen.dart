import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/welcome/local_widgets/auth_button.welcome.dart';
import 'package:safe/screens/welcome/local_widgets/bubbles.welcome.dart';
import 'package:safe/utils/constants/constants.util.dart';
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
        Positioned(
          bottom: -175,
          child: SizedBox(
            width: queryData.size.width,
            height: queryData.size.height,
            child: Stack(
              children: List.generate(
                4,
                (index) => Bubble(index),
              ),
            ),
          ),
        ),
        ...core.utils.flows.signup.widgets
      ],
      body: Container(
        // Position the buttons & logo in the screen
        padding: EdgeInsets.only(bottom: (queryData.size.height / 2) + 50),
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
            AuthButton(AuthButtonType.signup),
            SizedBox(height: 16),
            AuthButton(AuthButtonType.login),
          ],
        ),
      ),
    );
  }
}
