import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableOverlay extends StatefulWidget {
  final Widget? child;
  final OverlayController? controller;

  MutableOverlay({
    this.child,
    this.controller,
  });

  @override
  State<MutableOverlay> createState() => _MutableOverlayState();
}

class _MutableOverlayState extends State<MutableOverlay>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double opacity = 0;

  @override
  void initState() {
    initializeAnimation();

    if (widget.controller != null) {
      widget.controller!.setState(this);
    }

    super.initState();
  }

  void initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    Animation animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    controller.addListener(() {
      setState(() {
        opacity = animation.value;
      });
    });
  }

  Future<void> show() async {
    controller.forward();
  }

  Future<void> hide() async {
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return opacity != 0
        ? Opacity(
            opacity: opacity,
            child: Container(
              color:
                  kColorMap[MutableColor.neutral10]!.withOpacity(opacity * 0.8),
              child: widget.child,
            ),
          )
        : SizedBox();
  }
}

class OverlayController {
  _MutableOverlayState? _state;

  // ignore: library_private_types_in_public_api
  void setState(_MutableOverlayState state) => _state = state;

  bool get isAttached => _state != null;

  Future<void> show() async {
    assert(_state != null, "Controller has not been attached");
    await _state!.show();
  }

  Future<void> hide() async {
    assert(_state != null, "Controller has not been attached");
    await _state!.hide();
  }
}
