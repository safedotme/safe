import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableGradientShimmer extends StatefulWidget {
  final Widget Function(GlobalKey key) builder;
  final double borderRadius;
  MutableGradientShimmer({
    required this.builder,
    this.borderRadius = 0,
  });

  @override
  State<MutableGradientShimmer> createState() => _MutableGradientShimmerState();
}

class _MutableGradientShimmerState extends State<MutableGradientShimmer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  final GlobalKey key = GlobalKey();
  Size? size;
  double state = 0;

  void animate() {
    controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(milliseconds: 2000),
    );

    controller.repeat(reverse: true);

    controller.addListener(() {
      setState(() {
        state = controller.value;
      });
    });
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchChildData();
    });

    animate();
    super.initState();
  }

  void fetchChildData() {
    if (key.currentContext == null) return;

    final box = key.currentContext!.findRenderObject() as RenderBox?;

    if (box == null) return;

    setState(() {
      size = box.size;
    });

    //TODO: ANIMATE
  }

  double genAnimate(double a, double b, double c, bool increase) {
    double min = a;
    double max = b;
    double perc = 0;

    if (a > b) {
      min = b;
      max = a;
    }

    if (c >= max) {
      perc = 1;
    } else if (c <= min) {
      perc = 0;
    } else {
      perc = (c - min) / (a - b).abs();
    }

    return increase ? perc : 1 - perc;
  }

  double genOpacity(double state) {
    double s = 0;

    if (state > 0.5) {
      s = genAnimate(0.55, 0.95, state, false);
    } else {
      s = genAnimate(0.05, 0.45, state, true);
    }

    return s * 0.4;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.builder(key),
        size == null
            ? SizedBox()
            : Container(
                height: size!.height,
                width: size!.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  gradient: LinearGradient(colors: [
                    kColorMap[MutableColor.primaryOrange]!.withOpacity(0),
                    kColorMap[MutableColor.primaryRed]!
                        .withOpacity(genOpacity(state)),
                    kColorMap[MutableColor.primaryMagenta]!.withOpacity(0),
                  ], stops: [
                    0,
                    1 * state,
                    1,
                  ]),
                ),
              ),
      ],
    );
  }
}
