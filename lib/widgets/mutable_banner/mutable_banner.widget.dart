import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

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
        child: GestureDetector(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          child: Container(
            width: double.infinity,
            height: 64,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: core.utils.color.translucify(
                widget.type == MessageType.success
                    ? MutableColor.secondaryGreen
                    : MutableColor.secondaryRed,
                Transparency.v16,
              ),
              border: Border.all(
                color: kColorMap[widget.type == MessageType.success
                    ? MutableColor.secondaryGreen
                    : MutableColor.secondaryRed]!,
                width: kBorderWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
