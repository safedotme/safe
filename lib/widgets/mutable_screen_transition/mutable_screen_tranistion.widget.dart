import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableScreenTransition extends StatefulWidget {
  final Widget body;
  final ScreenTransitionController? controller;
  final bool isOpen;
  final double minSizePercentage;

  MutableScreenTransition({
    required this.body,
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
      print(
          "WORKING"); // THIS IS THE ISSUE (its not being called a second time around)
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
    forward = state < 0.5;
    isDragging = false;

    // Could be not changing is dragging OR dragController is not working second time around
    await dragController.forward();

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
      topPosAnimation ??= genAnimation(
        begin: drag!,
        end: (forward ? drag! + 200 : 0).toDouble(),
      );

      print("HERE");

      return topPosAnimation!.value; // ANIMATE DRAG BACK TO 0 or ADD 200
    }

    double moved = (initialDrag! - drag!);
    return moved.isNegative ? moved.abs() : 0;
  }

  // -> Generates a value between 5 and 15
  double genRad(double s) => 5 + (10 * difference(s));

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
      child: Positioned(
        top: genTopPos(state),
        child: GestureDetector(
          onVerticalDragUpdate: (dragUpdate) {
            updateState(dragUpdate.globalPosition.dy);
          },
          onVerticalDragStart: (dragStart) {
            isDragging = true;
            isGestured = true;
            forward = false;
          },
          onVerticalDragEnd: (dragEnd) {
            endDragAnimation();
          },
          child: Transform.scale(
            scale: genScale(state),
            child: Opacity(
              opacity: genOpacity(state),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(genRad(state)),
                child: SizedBox(
                  height: queryData.size.height,
                  width: queryData.size.width,
                  child: widget.body,
                ),
              ),
            ),
          ),
        ),
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
