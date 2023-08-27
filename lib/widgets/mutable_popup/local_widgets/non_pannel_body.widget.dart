import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_gradient_border/local_widgets/gradient_border_painter.widget.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';

class NonPannelBody extends StatefulWidget {
  final Size size;
  final MutablePopupStyle style;
  final Widget? body;
  final bool isExcited;

  NonPannelBody({
    required this.size,
    required this.style,
    required this.isExcited,
    this.body,
  });

  @override
  State<NonPannelBody> createState() => _NonPannelBodyState();
}

class _NonPannelBodyState extends State<NonPannelBody> {
  late Core core;

  @override
  void initState() {
    core = Provider.of<Core>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: widget.size.height,
        width: widget.size.width,
        decoration: BoxDecoration(
          color: widget.style.backgroundColor,
          gradient: !widget.isExcited
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.alphaBlend(
                      kColorMap[MutableColor.excitedPrimary]!.withOpacity(0.1),
                      kColorMap[MutableColor.excitedBackground]!,
                    ),
                    Color.alphaBlend(
                      kColorMap[MutableColor.excitedPrimary]!.withOpacity(0.03),
                      kColorMap[MutableColor.excitedBackground]!,
                    ),
                  ],
                ),
          border: !widget.isExcited ? widget.style.border : null,
          borderRadius: widget.style.borderRadius,
        ),
        child: !widget.isExcited
            ? widget.body
            : CustomPaint(
                painter: GradientBorderPainter(
                    width: kExcitedBorderWidth,
                    borderRadius: widget.style.borderRadius!.topRight.y,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      kColorMap[MutableColor.excitedPrimary]!,
                      kColorMap[MutableColor.excitedPrimary]!.withOpacity(0.2),
                      kColorMap[MutableColor.excitedPrimary]!.withOpacity(0.1),
                    ]),
                child: widget.body,
              ),
      ),
    );
  }
}
