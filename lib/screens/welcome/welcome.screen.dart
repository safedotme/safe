import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/welcome/local_widgets/bubbles.welcome.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
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
  late BannerController controller;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    controller = BannerController();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutableScaffold(
      overlays: [
        Positioned(
          bottom: -150,
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
      ],
      body: Container(
        padding: EdgeInsets.only(bottom: (queryData.size.height / 2) + 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.ac_unit,
                  size: 44,
                  color: Colors.white,
                ),
                SizedBox(width: 14),
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
            Container(
              height: 54,
              width: 228,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Container(
              height: 54,
              width: 228,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
