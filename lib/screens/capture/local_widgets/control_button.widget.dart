import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ControlButton extends StatelessWidget {
  final void Function() onTap;
  final MutableIcons icon;
  final String text;
  final bool active;
  final Size iconSize;

  ControlButton({
    required this.icon,
    required this.onTap,
    required this.text,
    this.active = false,
    this.iconSize = const Size(10, 10),
  });

  Widget borderWrapper({required Widget child}) => active
      ? MutableGradientBorder(
          width: 3,
          borderRadius: kCaptureControlBorderRadius,
          child: child,
        )
      : child;

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);

    return Expanded(
      child: MutableButton(
        onTap: onTap,
        child: borderWrapper(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kColorMap[MutableColor.neutral8],
                  border: Border.all(
                    width: kBorderWidth,
                    color: kColorMap[MutableColor.neutral7]!,
                  ),
                  borderRadius:
                      BorderRadius.circular(kCaptureControlBorderRadius),
                ),
                child: Row(
                  children: [
                    MutableIcon(icon, size: iconSize),
                    SizedBox(width: 8),
                    MutableText(text),
                    Spacer(),
                    Visibility(
                      visible: !active,
                      child: MutableIcon(
                        MutableIcons.caretRight,
                        size: Size(8, 14),
                        color: core.utils.color.translucify(
                          MutableColor.neutral2,
                          Transparency.v80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: active,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(kCaptureControlBorderRadius),
                    gradient: LinearGradient(
                      begin: kPrimaryGradientAlignmentBegin,
                      end: kPrimaryGradientAlignmentEnd,
                      colors: kPrimaryGradientColors
                          .map((e) => e.withOpacity(0.2))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
