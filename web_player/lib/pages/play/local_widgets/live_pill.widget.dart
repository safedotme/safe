import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class LivePill extends StatefulWidget {
  @override
  State<LivePill> createState() => _LivePillState();
}

class _LivePillState extends State<LivePill> with TickerProviderStateMixin {
  double state = 1;
  late AnimationController controller;

  @override
  void initState() {
    animate();
    super.initState();
  }

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    final a = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutSine,
      ),
    );

    controller.addListener(() {
      setState(() {
        state = a.value;
      });
    });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    if (controller.isAnimating) {
      controller.stop();
    }

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1 + 0.9 * state,
      child: Container(
        height: 24,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: kColorMap[MutableColor.overlaySecondaryRed],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: kBorderWidth,
            color: kColorMap[MutableColor.secondaryRed]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kColorMap[MutableColor.secondaryRed],
              ),
            ),
            SizedBox(width: 4),
            MutableText(
              "Live".toUpperCase(),
              size: 14.4,
              color: MutableColor.secondaryRed,
              weight: TypeWeight.heavy,
              letterSpacing: LetterSpacingType.numeric,
            ),
          ],
        ),
      ),
    );
  }
}
