import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

enum MessageType {
  error,
  success,
}

class MutableBanner extends StatefulWidget {
  final MessageType type;
  final String title;
  final BannerController? controller;
  final Duration? duration;
  final String description;
  final void Function()? onTap;

  MutableBanner({
    this.type = MessageType.success,
    this.controller,
    this.duration,
    this.title = "",
    this.description = "",
    this.onTap,
  });

  @override
  State<MutableBanner> createState() => _MutableBannerState();
}

class _MutableBannerState extends State<MutableBanner>
    with TickerProviderStateMixin {
  late Core core;
  late MediaQueryData queryData;

  // Properties for animation
  late AnimationController controller;
  late Animation positionAnimation;
  late Animation opacityAnimation;
  late Animation scaleAnimation;
  double topPosition = -116;
  double opacity = 0;
  bool dismissed = false;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);

    if (widget.controller != null) {
      widget.controller!.setState(this);
    }

    // Initialize controller
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    // Initialize animations
    positionAnimation = Tween<double>(begin: -116.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    );

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCirc),
    );

    controller.addListener(() {
      setState(() {
        topPosition = positionAnimation.value;
        opacity = opacityAnimation.value;
      });
    });
  }

  Future<void> show() async {
    dismissed = false;
    await controller.forward();
    await Future.delayed(widget.duration ?? Duration(seconds: 3));
    if (!dismissed) {
      await controller.reverse();
    }
  }

  Future<void> dismiss() async {
    dismissed = true;
    await controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Positioned(
      top: topPosition,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: queryData.size.width,
          height: 115,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kColorMap[MutableColor.neutral10]!
                    .withOpacity(kTransparencyMap[Transparency.v80]!),
                kColorMap[MutableColor.neutral10]!.withOpacity(0),
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: kSideScreenMargin,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: MutableButton(
              onTap: () {
                dismiss();
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              child: Container(
                width: double.infinity,
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: ShapeDecoration(
                  color: core.utils.color.translucify(
                    widget.type == MessageType.success
                        ? MutableColor.secondaryGreen
                        : MutableColor.secondaryRed,
                    Transparency.v16,
                  ),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerSmoothing: kCornerSmoothing,
                      cornerRadius: 16,
                    ),
                    side: BorderSide(
                      color: kColorMap[widget.type == MessageType.success
                          ? MutableColor.secondaryGreen
                          : MutableColor.secondaryRed]!,
                      width: kBorderWidth,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MutableText(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      weight: TypeWeight.semiBold,
                      style: TypeStyle.body,
                    ),
                    SizedBox(height: 2),
                    MutableText(
                      widget.description,
                      maxLines: 1,
                      size: 13,
                      overflow: TextOverflow.ellipsis,
                      weight: TypeWeight.regular,
                      color: MutableColor.neutral2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BannerController {
  _MutableBannerState? _state;

  // ignore: library_private_types_in_public_api
  void setState(_MutableBannerState state) => _state = state;

  bool get isAttached => _state != null;

  Future<void> show() async {
    assert(_state != null, "Controller has not been attached");
    await _state!.show();
  }

  Future<void> dismiss() async {
    assert(_state != null, "Controller has not been attached");
    await _state!.dismiss();
  }
}
