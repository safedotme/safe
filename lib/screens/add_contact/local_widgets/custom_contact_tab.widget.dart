import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomContactTab extends StatefulWidget {
  final void Function() onTap;
  final String name;
  final String phone;

  CustomContactTab({
    required this.onTap,
    required this.name,
    required this.phone,
  });

  @override
  State<CustomContactTab> createState() => _CustomContactTabState();
}

class _CustomContactTabState extends State<CustomContactTab>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double state = 0;

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
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    controller.addListener(() {
      setState(() {
        state = animation.value;
      });
    });

    super.initState();
  }

  Future<void> animate() async {
    await controller.forward(from: 0);
    await Future.delayed(Duration(milliseconds: 50));
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        animate();
        widget.onTap();
      },
      child: Container(
        color: Colors.white.withOpacity(0.2 * state),
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontFamily: "TextRegular",
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              widget.phone,
              style: TextStyle(
                fontFamily: "TextRegular",
                color: Color(0xffEBEBF5).withOpacity(0.6),
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
