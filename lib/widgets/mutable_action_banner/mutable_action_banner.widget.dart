import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableActionBanner extends StatefulWidget {
  final ActionBannerController? controller;

  MutableActionBanner({this.controller});

  @override
  State<MutableActionBanner> createState() => _MutableActionBannerState();
}

class _MutableActionBannerState extends State<MutableActionBanner>
    with TickerProviderStateMixin {
  String text = "";
  MessageType type = MessageType.success;
  late AnimationController animation;
  late Animation a;
  bool canCall = true;

  double state = 0;

  Future<void> trigger(String msg, MessageType type, {Duration? wait}) async {
    setState(() {
      text = msg;
      this.type = type;
    });

    if (!canCall) return;
    canCall = false;

    await animation.forward();
    await Future.delayed(wait ?? Duration(seconds: 3));
    await animation.reverse();
    canCall = true;
  }

  @override
  void dispose() {
    if (animation.isAnimating) {
      animation.stop();
      animation.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller!.setState(this);
    }
    super.initState();

    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    a = Tween<double>(begin: state, end: 1).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.decelerate,
    ));

    animation.addListener(() {
      setState(() {
        state = a.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state != 011,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Opacity(
          opacity: state,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kColorMap[MutableColor.neutral10]!.withOpacity(0),
                  kColorMap[MutableColor.neutral10]!.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40 * state),
                child: Transform.scale(
                  scale: 1 - ((state - 1).abs() * 0.5),
                  child: Container(
                    height: 37,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: kColorMap[type == MessageType.success
                          ? MutableColor.overlaySecondaryGreen
                          : type == MessageType.error
                              ? MutableColor.overlaySecondaryRed
                              : MutableColor.overlaySecondaryYellow]!,
                      border: Border.all(
                        width: kBorderWidth,
                        color: kColorMap[type == MessageType.success
                            ? MutableColor.secondaryGreen
                            : type == MessageType.error
                                ? MutableColor.secondaryRed
                                : MutableColor.secondaryYellow]!,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/${type == MessageType.success ? "checkmark" : type == MessageType.error ? "error" : "warning"}.png",
                          height: 14,
                        ),
                        SizedBox(width: 12),
                        MutableText(
                          text,
                          size: 14,
                          weight: TypeWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActionBannerController {
  _MutableActionBannerState? _state;

  bool get isAttached => _state != null;

  // ignore: library_private_types_in_public_api
  void setState(_MutableActionBannerState s) => _state = s;

  void trigger(String message, MessageType type) {
    assert(_state != null, "The controller is not attached");

    _state!.trigger(message, type);
  }
}
