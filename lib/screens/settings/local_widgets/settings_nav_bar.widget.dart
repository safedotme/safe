import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class SettingsNavBar extends StatefulWidget {
  @override
  State<SettingsNavBar> createState() => _SettingsNavBarState();
}

class _SettingsNavBarState extends State<SettingsNavBar> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        core.state.preferences.scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 200),
          curve: Curves.decelerate,
        );
      },
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: kNavBarBlur,
            sigmaY: kNavBarBlur,
          ),
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: kColorMap[MutableColor.neutral10]!.withOpacity(0.7),
              border: Border(
                bottom: BorderSide(
                  width: kBorderWidth,
                  color: kColorMap[MutableColor.neutral7]!,
                ),
              ),
            ),
            padding: EdgeInsets.fromLTRB(
              10,
              0,
              10,
              12,
            ),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MutableButton(
                  scale: 0.8,
                  onTap: () {
                    core.state.preferences.controller.close();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 25,
                    width: 30,
                    child: Center(
                      child: MutableIcon(
                        MutableIcons.cancel,
                        color: Colors.white,
                        size: Size(16, 16),
                      ),
                    ),
                  ),
                ),
                MutableText(
                  core.utils.language
                          .langMap[core.state.preferences.language]!["settings"]
                      ["header"],
                  size: 18,
                  weight: TypeWeight.bold,
                ),
                SizedBox(width: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
