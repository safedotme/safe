import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableLiveBadge extends StatefulWidget {
  @override
  State<MutableLiveBadge> createState() => _MutableLiveBadgeState();
}

class _MutableLiveBadgeState extends State<MutableLiveBadge>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double state = 0;
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    animate();
  }

  @override
  void dispose() {
    if (controller.isAnimating) {
      controller.stop();
    }
    controller.dispose();

    super.dispose();
  }

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 550),
    );

    final animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    controller.addListener(() {
      setState(() {
        state = animation.value;
      });
    });

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: kBorderWidth,
          color: kColorMap[MutableColor.secondaryRed]!,
        ),
        color: kColorMap[MutableColor.overlaySecondaryRed],
      ),
      padding: EdgeInsets.fromLTRB(6, 0, 8, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 9,
            width: 9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kColorMap[MutableColor.secondaryRed]!.withOpacity(
                0.2 + 0.8 * state,
              ),
            ),
          ),
          SizedBox(width: 4),
          MutableText(
            core.utils.language
                .langMap[core.state.preferences.language]!["capture"]["live"]
                .toUpperCase(),
            size: 14.5,
            weight: TypeWeight.heavy,
            color: MutableColor.secondaryRed,
          ),
        ],
      ),
    );
  }
}
