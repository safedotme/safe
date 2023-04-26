import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_message_page/mutable_message_page.widget.dart';

class MutableMessageIcon extends StatelessWidget {
  final MessageType type;
  MutableMessageIcon(this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMessageBannerIconSize,
      width: kMessageBannerIconSize,
      decoration: BoxDecoration(
        color: kColorMap[type == MessageType.success
                ? MutableColor.secondaryGreen
                : type == MessageType.warning
                    ? MutableColor.secondaryYellow
                    : MutableColor.secondaryRed]!
            .withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          width: kBorderWidth,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Center(
        child: Image.asset(
          "assets/images/${type == MessageType.success ? "checkmark" : type == MessageType.warning ? "warning" : "error"}.png",
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
