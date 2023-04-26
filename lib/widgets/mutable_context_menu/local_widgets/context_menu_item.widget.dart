import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ContextMenuItem extends StatefulWidget {
  final void Function() onTap;
  final String text;
  final MutableIcon icon;

  ContextMenuItem({
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  State<ContextMenuItem> createState() => _ContextMenuItemState();
}

class _ContextMenuItemState extends State<ContextMenuItem>
    with TickerProviderStateMixin {
  double opacity = 0;
  late AnimationController controller;
  late Animation<double> animation;

  void initialize() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 130),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    controller.addListener(() {
      setState(() {
        opacity = animation.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onTap();
        HapticFeedback.lightImpact();
        await controller.forward();
        await controller.reverse();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 11,
        ),
        color: Colors.white.withOpacity(opacity * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MutableText(
              widget.text,
              size: 17,
              decoration: TextDecoration.none,
              weight: TypeWeight.regular,
            ),
            widget.icon,
          ],
        ),
      ),
    );
  }
}
