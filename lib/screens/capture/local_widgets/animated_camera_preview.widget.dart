import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/capture/local_widgets/camera_feed.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';

class AnimatedCameraPreview extends StatefulWidget {
  /// ⬇️ ANIMATION HELPER METHODS
  static double generateScaleCoeffcient(MediaQueryData query) {
    double coeff = (query.size.width - (kSideScreenMargin * 2)) /
        (kCameraPreviewWidthPercentage * query.size.width);
    return coeff;
  }

  static double generatePosYCoefficient(MediaQueryData query) {
    double box = kControlBoxBodyHeight * generateScaleCoeffcient(query);
    double topMargin = 20; // Margin from top of preview to notch
    double coeff = query.size.height - (query.padding.top + box + topMargin);
    return coeff;
  }

  @override
  State<AnimatedCameraPreview> createState() => _AnimatedCameraPreviewState();
}

class _AnimatedCameraPreviewState extends State<AnimatedCameraPreview>
    with TickerProviderStateMixin {
  late Core core;
  late AnimationController controller;
  late Animation<double> animation;
  double scaleState = 1;

  /// ⬇️ ANIMATION FIELDS
  late AnimationController ticker;
  late Animation<double> engine;
  late MediaQueryData queryData;

  /// ⬇️ ANIMATION STATE
  bool canDrag = false;
  bool isAnimating = false;
  double state = 0; // 0 is CLOSED | 1 is OPEN
  double bottom = kBottomScreenMargin;
  double scale = 1;
  double blur = 0;

  /// ⬇️ ANIMATION HELPER METHODS
  double diff(double a, double b) => (a - b).abs();

  void initAnimation() {
    ticker = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  Future<void> animate({
    required double begin,
    required double end,
    bool reverse = false,
    required Function() listener,
  }) async {
    engine = Tween<double>(
      begin: reverse ? end : begin,
      end: reverse ? begin : end,
    ).animate(
      CurvedAnimation(
        parent: ticker,
        curve: Curves.ease,
      ),
    );

    ticker.addListener(listener);

    await ticker.forward(from: 0);
    ticker.removeListener(listener);
  }

  /// ⬇️ ANIMATION METHODS
  Future<void> animateUpFromBase() async {
    setState(() {
      isAnimating = true;
    });

    await animate(
        begin: 0,
        end: 1,
        listener: () {
          setState(() {
            core.state.capture.setEnglargmentState(engine.value);

            bottom = kBottomScreenMargin +
                (diff(
                        kBottomScreenMargin,
                        AnimatedCameraPreview.generatePosYCoefficient(
                          queryData,
                        )) *
                    engine.value);
          });
        });

    setState(() {
      canDrag = true;
    });
  }

  Future<void> animateUpFromPosition() async {
    // Hanlde Position
  }

  Future<void> animateEnd() async {
    // Will be handled from user position
    // Handle Scale
    // Handle Blur
    // Handle Position
    // FINAL: canDrag set to False

    setState(() {
      isAnimating = true;
    });
  }

  Future<void> animateDrag() async {
    // Will call functions above on VerticalDrag End

    /// if (position > 80% of screen) => animate up
    /// if (position =< 80% of screen) => animate down
  }

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
    initAnimation();
    initButtonAnimation();
  }

  double genBottomPosition(double panelPosition) {
    double def = kBottomScreenMargin;

    if (isAnimating) return bottom;

    if (panelPosition != 0) {
      return def - ((core.state.capture.panelHeight - 100) * panelPosition);
    }

    return def;
  }

  void initButtonAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: kScaleDownButtonTime,
    );

    animation = Tween<double>(
      begin: 1,
      end: kScaleDownButtonPercentage,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    controller.addListener(() {
      setState(() {
        scaleState = animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Observer(
      builder: (context) {
        return Positioned(
          bottom:
              genBottomPosition(((core.state.capture.offset - 1) * -1).abs()),
          left: kSideScreenMargin,
          child: Opacity(
            opacity: (core.state.capture.offset).abs(),
            child: Transform.scale(
              // Handles enlargment scale
              scale: scale,
              alignment: Alignment.bottomLeft,
              child: Transform.scale(
                // Handles press effect scale
                scale: scaleState,
                child: GestureDetector(
                  onLongPressStart: (details) async {
                    HapticFeedback.mediumImpact();
                    await controller.forward();
                    await Future.delayed(Duration(milliseconds: 200));
                    controller.reverse();

                    animateUpFromBase();
                  },
                  onVerticalDragUpdate: !canDrag
                      ? null
                      : (details) {
                          print(details);
                        },
                  onLongPressEnd: (details) {},
                  child: CameraFeed(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
