import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class AddContactButton extends StatefulWidget {
  final void Function()? onTap;
  AddContactButton({this.onTap});
  @override
  State<AddContactButton> createState() => _AddContactButtonState();
}

class _AddContactButtonState extends State<AddContactButton>
    with TickerProviderStateMixin {
  late Core core;
  late AnimationController controller;
  bool local = false;
  double state = 0;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
    initAnimation();
  }

  void initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  void animate(bool global) {
    if (global == local) return;
    local = global;

    // ⬇️ Animate
    final animation = Tween<double>(
      begin: state,
      end: (state - 1).abs(),
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    );

    controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          state = animation.value;
        });
      });
    });

    controller.forward(from: 0);
  }

  @override
  void dispose() {
    if (controller.isAnimating) {
      controller.stop();
    }

    controller.dispose();
    super.dispose();
  }

  Color generateColor(Color c, double state) {
    final color = kColorMap[MutableColor.neutral4]!;
    int rDiff = color.red - c.red;
    int gDiff = color.green - c.green;
    int bDiff = color.blue - c.blue;

    return Color.fromRGBO(
      c.red + (rDiff * state).round(),
      c.green + (gDiff * state).round(),
      c.blue + (bDiff * state).round(),
      1,
    );
  }

  bool checkCap() {
    final cap = core.state.capture.settings?.defaultContactCap;
    final amm = core.state.contact.contacts?.length;

    if (amm == null || cap == null) return false;
    return amm >= cap;
  }

  int? fetchCap() => core.state.capture.settings?.defaultContactCap;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        animate(core.state.contact.isEditing || checkCap());

        return MutableButton(
          scale: 0.9,
          onTap: () async {
            if (checkCap()) {
              core.state.preferences.actionController.trigger(
                core
                    .utils
                    .language
                    .langMap[core.state.preferences.language]!["contact"]
                        ["errors"]["capped"]
                    .replaceAll(
                  "{AMMOUNT}",
                  "${fetchCap()}",
                ),
                MessageType.error,
              );
              return;
            }

            if (core.state.contact.isEditing) return;

            widget.onTap?.call();
            HapticFeedback.lightImpact();

            await core.state.contact.controller.close();
            core.state.contact.importContactPopupController.open();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: kPrimaryGradientColors
                          .map(
                            (c) => generateColor(c, state),
                          )
                          .toList(),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: MutableIcon(
                      MutableIcons.plus,
                      color: Colors.white.withOpacity(
                        0.3 + (0.7 * (1 - state).abs()),
                      ),
                      size: Size(10, 10),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                MutableText(
                  core.utils.language
                          .langMap[core.state.preferences.language]!["contact"]
                      ["add_button"],
                  align: TextAlign.left,
                  customColor: generateColor(Colors.white, state),
                  weight: TypeWeight.semiBold,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
