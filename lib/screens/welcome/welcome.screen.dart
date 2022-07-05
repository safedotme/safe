import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Core core;
  late BannerController controller;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    controller = BannerController();
  }

  @override
  Widget build(BuildContext context) {
    return MutableScaffold(
      overlays: [
        // List.generate
        Bubble(0),
      ],
      body: Container(),
    );
  }
}

class Bubble extends StatefulWidget {
  final int index;

  Bubble(this.index);
  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with TickerProviderStateMixin {
  late double size;
  late AnimationController controller;
  late Animation animation;
  late MediaQueryData queryData;
  double scale = 1;

  Future<void> animate() async {
    int baseline = 1080;
    int increment = 352;
    double breathIncrement = 0.15;

    // Animate into scene
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: baseline + (increment * widget.index)),
    );

    animation = Tween<double>(begin: 0.0, end: 1 + breathIncrement).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    controller.addListener(() {
      setState(() {
        scale = animation.value;
      });
    });

    await controller.forward();

    // Animate pulsations
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    animation = Tween<double>(begin: 1 + breathIncrement, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.addListener(() {
      setState(() {
        scale = animation.value;
      });
    });

    controller.repeat(reverse: true);
  }

  // Generates size
  void genSize() {
    double baseline = 540;
    double increment = 176;

    size = baseline + (increment * widget.index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Generates base size for bubbles
    genSize();

    // Animate bubble
    //animate();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Positioned(
      bottom: -size * 0.8,
      right: (queryData.size.width / 2) - (size / 2),
      child: Transform.scale(
        scale: scale,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            // Red
            BoxShadow(
              offset: Offset(-4, -4),
              blurRadius: 20,
              color: kColorMap[MutableColor.primaryRed]!.withOpacity(0.1),
            ),

            // Purple
            BoxShadow(
              offset: Offset(-4, -4),
              blurRadius: 20,
              color: kColorMap[MutableColor.primaryPurple]!.withOpacity(0.1),
            ),

            // Yellow
            BoxShadow(
              offset: Offset(-4, -4),
              blurRadius: 20,
              color: kColorMap[MutableColor.primaryYellow]!.withOpacity(0.1),
            ),
          ]),
        ),
      ),
    );
  }
}
