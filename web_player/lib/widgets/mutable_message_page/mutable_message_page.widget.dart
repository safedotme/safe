import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_circular_progress_indicator.widget.dart/mutable_circular_progress_indicator.widget.dart';
import 'package:safe/widgets/mutable_page/mutable_page.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

enum MessageType {
  success,
  warning,
  error,
}

class MutableMessagePage extends StatelessWidget {
  final MessageType type;
  final String header;
  final String description;
  final bool loading;

  MutableMessagePage({
    required this.type,
    this.loading = false,
    required this.header,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    return MutablePage(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          38,
          queryData.size.height * 0.2,
          38,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class AnimatedCircularProgressIndicator extends StatefulWidget {
  @override
  State<AnimatedCircularProgressIndicator> createState() =>
      _AnimatedCircularProgressIndicatorState();
}

class _AnimatedCircularProgressIndicatorState
    extends State<AnimatedCircularProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    animate();
    super.initState();
  }

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
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
    return SizedBox(
      height: 64,
      width: 64,
      child: CustomPaint(
        painter: MutableCircularProgressIndicator(
          frontColor: Colors.white,
          backColor: kColorMap[MutableColor.neutral7]!,
          strokeWidth: 10,
          value: animation.value,
        ),
      ),
    );
  }
}
