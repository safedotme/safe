import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/welcome/welcome.screen.dart';
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
  final String description;
  final void Function()? onTap;

  MutableBanner({
    this.type = MessageType.success,
    this.title = "",
    this.description = "",
    this.onTap,
  });

  @override
  State<MutableBanner> createState() => _MutableBannerState();
}

class _MutableBannerState extends State<MutableBanner> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          onTap: widget.onTap,
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
    );
  }
}
