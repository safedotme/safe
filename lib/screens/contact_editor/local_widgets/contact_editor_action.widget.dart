import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ContactEditorAction extends StatelessWidget {
  final bool active;
  final void Function()? onTap;
  final String text;

  ContactEditorAction({
    required this.text,
    this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      scale: 0.9,
      onTap: onTap,
      child: Container(
        height: 60,
        color: Colors.transparent,
        child: Center(
          child: ShaderMask(
            shaderCallback: (rect) => LinearGradient(
              colors: active
                  ? kPrimaryGradientColors.sublist(
                      1,
                      kPrimaryGradientColors.length - 1,
                    )
                  : [
                      kColorMap[MutableColor.neutral3]!,
                      kColorMap[MutableColor.neutral3]!,
                    ],
            ).createShader(rect),
            child: MutableText(
              text,
              size: 20,
              weight: active ? TypeWeight.bold : TypeWeight.medium,
            ),
          ),
        ),
      ),
    );
  }
}
