import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:shimmer/shimmer.dart';

enum Speed {
  slow,
  fast,
  intermidiate,
}

class MutableShimmer extends StatelessWidget {
  final Widget child;
  final Color? animateToColor;
  final Speed speed;
  final bool active;

  MutableShimmer({
    required this.child,
    this.animateToColor,
    this.active = true,
    this.speed = Speed.intermidiate,
  });

  final Map<Speed, Duration> speedMap = {
    Speed.fast: Duration(milliseconds: 800),
    Speed.intermidiate: Duration(milliseconds: 1300),
    Speed.slow: Duration(milliseconds: 2000),
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        active
            ? Shimmer.fromColors(
                period: speedMap[speed]!,
                baseColor: animateToColor != null
                    ? animateToColor!.withOpacity(0)
                    : kColorMap[MutableColor.neutral1]!.withOpacity(0.0),
                highlightColor: animateToColor != null
                    ? animateToColor!
                    : kColorMap[MutableColor.neutral1]!.withOpacity(0.25),
                child: child,
              )
            : SizedBox(),
      ],
    );
  }
}
