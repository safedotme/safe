import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class CaptureTextShimmer extends StatefulWidget {
  final CaptureTextShimmerController? controller;

  CaptureTextShimmer({this.controller});

  @override
  State<CaptureTextShimmer> createState() => _CaptureTextShimmerState();
}

class _CaptureTextShimmerState extends State<CaptureTextShimmer>
    with TickerProviderStateMixin {
  late AnimationController swingController;
  late AnimationController opacityController;
  late Core core;
  double stop = 0;
  double opacity = 0;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    core = Provider.of<Core>(context, listen: false);
    init();

    if (widget.controller != null) {
      widget.controller!.setState(this);
    }
  }

  void init() {
    swingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    swingController.addListener(() {
      setState(() {
        stop = swingController.value;
      });
    });

    opacityController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    var animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: opacityController,
        curve: Curves.easeIn,
      ),
    );

    opacityController.addListener(() {
      setState(() {
        opacity = animation.value;
      });
    });
  }

  Future<void> animate() async {
    int rounds = 5;
    opacityController.forward();
    for (int i = 0; i < rounds; i++) {
      if (i + 1 == rounds) {
        opacityController.reverse();
      }

      if (i.isEven) {
        await swingController.forward();
      } else {
        await swingController.reverse();
      }
    }
  }

  @override
  void dispose() {
    swingController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: ShaderMask(
        shaderCallback: (rect) => LinearGradient(
          colors: [
            kCaptureTextShimmerDarkColor,
            kCaptureTextShimmerLightColor,
            kCaptureTextShimmerDarkColor,
          ],
          stops: [
            stop - 0.5,
            stop,
            stop + 0.5,
          ],
          begin: Alignment(1.2, 0),
          end: Alignment(-1.2, 0),
        ).createShader(rect),
        child: MutableText(
          core.utils.language
                  .langMap[core.state.preferences.language]!["capture"]
              ["hint"], // Extract
          align: TextAlign.center,
          style: TypeStyle.h3,
          weight: TypeWeight.heavy,
        ),
      ),
    );
  }
}

class CaptureTextShimmerController {
  _CaptureTextShimmerState? _state;

  // ignore: library_private_types_in_public_api
  void setState(_CaptureTextShimmerState s) => _state = s;

  bool get isAttached => _state != null;

  Future<void> animate() async {
    assert(_state != null, "Controller has not been attached");
    return _state!.animate();
  }
}
