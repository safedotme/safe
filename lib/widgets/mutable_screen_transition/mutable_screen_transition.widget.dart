import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableScreenTransition extends StatefulWidget {
  final Widget body;
  final ScreenTransitionController? controller;
  final bool isOpen;
  final Color? backgroundColor;
  final void Function()? onOpen;
  final void Function()? onClose;
  final bool isDismissable;
  final double minSizePercentage;

  MutableScreenTransition({
    required this.body,
    this.backgroundColor,
    this.onOpen,
    this.onClose,
    this.isDismissable = true,
    this.minSizePercentage = 0.8,
    this.isOpen = false,
    this.controller,
  });

  @override
  State<MutableScreenTransition> createState() =>
      _MutableScreenTransitionState();
}

class _MutableScreenTransitionState extends State<MutableScreenTransition>
    with TickerProviderStateMixin {
  AnimationController? controller;
  late AnimationController dragController;
  late MediaQueryData queryData;
  late Core core;

  /// ⬇️ STATE - (All properties are initialized based on [widget.isOpen])

  late double state; // 1=OPEN | 0=CLOSED
  late double scale; // 1=OPEN | widget.minSizePercentage=CLOSED
  late double position; // 0=OPEN | {depends on user input}=CLOSED
  late bool isGestured; // True when animation is gestured

  /// -> Specific to user animated
  double? initialDrag;
  bool forward = false; // TRUE=CLOSING | FALSE=OPENING
  bool isDragging = false;
  double? drag;
  Animation? topPosAnimation;
  Animation? opacityAnimation;
  Animation? scaleAnimation;

  // ⬇️ INIT FUNCTIONS

  /// -> Will initialize all STATE values based on [widget.isOpen]
  void init(bool isOpen) {
    if (isOpen) {
      state = 1;
      scale = 1;
      position = 0;
      isGestured = false;

      return;
    }

    state = 0;
    scale = 0;
    position = 0;
    isGestured = false;
  }

  // ⬇️ ANIMATION FUNCTIONS - (NON USER GENERATED)
  Future<void> initFinishAnimation() async {
    dragController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    dragController.addListener(() {
      setState(() {});
    });
  }

  Future<void> open() async {
    // From CLOSED to OPEN

    // Checks that screen is closed
    if (state != 0) {
      return;
    }

    // Sets STATE values
    isGestured = false;

    // Initializes animation
    controller = AnimationController(
      vsync: this,
      duration: kScreenTransitionDuration,
    );

    Animation animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller!,
        curve: kTransitionCurve,
      ),
    );

    controller!.addListener(() {
      setState(() {
        state = animation.value;
      });
    });

    await controller!.forward();

    if (widget.onOpen != null) {
      widget.onOpen!();
    }
  }

  Future<void> close() async {
    // From OPEN to CLOSED

    // Checks that screen is open
    if (state != 1) {
      return;
    }

    // Sets STATE values
    isGestured = false;

    // Initializes animation
    controller = AnimationController(
      vsync: this,
      duration: kScreenTransitionDuration,
    );

    Animation animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: kTransitionCurve,
      ),
    );

    controller!.addListener(() {
      setState(() {
        state = animation.value;
      });
    });

    await controller!.forward();
    if (widget.onClose != null) {
      widget.onClose!();
    }
  }

  // ⬇️ ANIMATION FUNCTIONS - (USER GENERATED)
  void updateState(double position) {
    if (!isGestured) {
      return;
    }

    if (initialDrag == null) {
      initialDrag = position;

      return;
    }

    drag = position;

    double animation = difference(core.utils.animation.percentBetweenPoints(
      lowerBound: initialDrag!,
      upperBound: initialDrag! + kScreenTransitionBounds,
      state: position,
    ));

    if (animation < 0.1) {
      endDragAnimation();

      return;
    }

    setState(() {
      state = animation;
    });
  }

  void endDragAnimation() async {
    forward = state < 0.8;
    isDragging = false;

    // Could be not changing is dragging OR dragController is not working second time around
    await dragController.forward();

    if (forward) {
      if (widget.onClose != null) {
        widget.onClose!();
      }
    } else {
      if (widget.onOpen != null) {
        widget.onOpen!();
      }
    }

    setState(() {
      state = forward ? 0 : 1;
      isGestured = false;
      initialDrag = null;
      drag = null;
      topPosAnimation = null;
      opacityAnimation = null;
      scaleAnimation = null;

      forward = false;
    });

    initFinishAnimation();
  }

  // ⬇️ VALUE GENERATION FUNCTIONS

  // -> Generate value between minSizePercentage and 1
  double genScale(double s) {
    if (isGestured) {
      if (isDragging) {
        return widget.minSizePercentage +
            (difference(widget.minSizePercentage) * s);
      }

      scaleAnimation ??= genAnimation(
        begin: widget.minSizePercentage +
            (difference(widget.minSizePercentage) * s),
        end: forward ? (widget.minSizePercentage / 2).toDouble() : 1,
      );

      return scaleAnimation!.value;
    }

    double half = widget.minSizePercentage * (3 / 5);
    return half + (difference(half) * s);
  }

  // -> Generates value between 0 - 1
  double genOpacity(double s) {
    if (!isGestured) {
      return s;
    }

    if (isDragging) {
      return 1;
    }

    opacityAnimation ??= genAnimation(
      begin: (forward ? 1 : 1).toDouble(),
      end: (forward ? 0 : 1).toDouble(),
    );

    return opacityAnimation!.value;
  }

  // -> Generates position
  double genTopPos(double s) {
    if (!isGestured) {
      return 0;
    }

    if (initialDrag == null) {
      return 0;
    }

    if (drag == null) {
      return 0;
    }

    if (!isDragging) {
      double moved = (initialDrag! - drag!).abs();
      topPosAnimation ??= genAnimation(
        begin: moved,
        end: (forward ? moved + 200 : 0).toDouble(),
      );

      return topPosAnimation!.value;
    }

    double moved = (initialDrag! - drag!);
    return moved.isNegative ? moved.abs() : 0;
  }

  // -> Generates a value between 5 and 15
  double genRad(double s) => 5 + (20 * difference(s));

  // ⬇️ HELPER FUNCTIONS
  double difference(double d) => (d - 1).abs();

  Animation<double> genAnimation({required double begin, required double end}) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: dragController,
        curve: Curves.decelerate,
      ),
    );
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    dragController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);

    // Initialize controller if there is one
    if (widget.controller != null) {
      widget.controller!.setState(this);
    }

    // Initializes STATE values
    init(widget.isOpen);
    initFinishAnimation();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Visibility(
      visible: state != 0,
      child: Stack(
        children: [
          Container(
            color: widget.backgroundColor != null
                ? widget.backgroundColor!.withOpacity(state)
                : kColorMap[MutableColor.neutral9]!.withOpacity(state * 0.5),
          ),
          Positioned(
            left: -kBorderWidth,
            top: genTopPos(state) - kBorderWidth,
            child: GestureDetector(
              onVerticalDragUpdate: (dragUpdate) {
                if (!widget.isDismissable) {
                  return;
                }

                updateState(dragUpdate.globalPosition.dy);
              },
              onVerticalDragStart: (dragStart) {
                if (!widget.isDismissable) {
                  return;
                }

                isDragging = true;
                isGestured = true;
                forward = false;
              },
              onVerticalDragEnd: (dragEnd) {
                if (!widget.isDismissable) {
                  return;
                }

                endDragAnimation();
              },
              child: Transform.scale(
                scale: genScale(state),
                child: Opacity(
                  opacity: genOpacity(state),
                  child: Container(
                    height: queryData.size.height + (kBorderWidth * 2),
                    width: queryData.size.width + (kBorderWidth * 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: kBorderWidth,
                        color: kColorMap[MutableColor.neutral8]!,
                      ),
                      borderRadius: BorderRadius.circular(genRad(state)),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(genRad(state) - kBorderWidth),
                      child: widget.body,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenTransitionController {
  _MutableScreenTransitionState? _state;

  // ignore: library_private_types_in_public_api
  void setState(_MutableScreenTransitionState s) => _state = s;

  bool get isAttached => _state != null;

  Future<void> close() async {
    assert(_state != null, "Controller has not been attached");
    _state!.close();
  }

  Future<void> open() async {
    assert(_state != null, "Controller has not been attached");
    _state!.open();
  }
}
