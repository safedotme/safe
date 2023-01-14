import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableActionBanner extends StatefulWidget {
  const MutableActionBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<MutableActionBanner> createState() => _MutableActionBannerState();
}

class _MutableActionBannerState extends State<MutableActionBanner> {
  String text = "Copied link";
  MessageType type = MessageType.success;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kColorMap[MutableColor.neutral10]!.withOpacity(0),
              kColorMap[MutableColor.neutral10]!.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedPadding(
            padding: EdgeInsets.only(bottom: 37),
            duration: Duration(
              milliseconds: 300,
            ),
            child: Container(
              height: 37,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: kColorMap[type == MessageType.success
                    ? MutableColor.overlaySecondaryGreen
                    : type == MessageType.error
                        ? MutableColor.overlaySecondaryRed
                        : MutableColor.overlaySecondaryYellow]!,
                border: Border.all(
                  width: kBorderWidth,
                  color: kColorMap[type == MessageType.success
                      ? MutableColor.secondaryGreen
                      : type == MessageType.error
                          ? MutableColor.secondaryRed
                          : MutableColor.secondaryYellow]!,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/${type == MessageType.success ? "checkmark" : type == MessageType.error ? "error" : "warning"}.png",
                    height: 14,
                  ),
                  SizedBox(width: 12),
                  MutableText(
                    text,
                    size: 14,
                    weight: TypeWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
