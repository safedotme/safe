import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';

class CachedImageLoader extends StatelessWidget {
  final Color? shimmerColor;
  final Color? backgroundColor;
  final bool isOval;

  CachedImageLoader({
    required this.isOval,
    this.shimmerColor,
    this.backgroundColor,
  });

  Widget generateOval(Widget w) => isOval ? ClipOval(child: w) : w;

  @override
  Widget build(BuildContext context) {
    return MutableShimmer(
      animateToColor: shimmerColor ?? kShimmerAnimationColor,
      child: generateOval(
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? kColorMap[MutableColor.neutral10]!,
          ),
        ),
      ),
    );
  }
}
