import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
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
  double scale = 1;

  Future<void> animate() async {
    int baseline = 1080;
    int increment = 352;
    // Animate into scene
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: baseline + (increment * widget.index)),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    controller.addListener(() {
      setState(() {
        scale = animation.value;
      });
    });

    await controller.forward();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    animation = Tween<double>(begin: 1, end: 1.15).animate(
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
    animate();
  }

  // 540
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: -80,
      child: Transform.scale(
        scale: scale,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red[(widget.index + 1) * 100],
          ),
        ),
      ),
    );
  }
}
