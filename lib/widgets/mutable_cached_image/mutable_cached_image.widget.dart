import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';

class MutableCachedImage extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final Color? shimmerColor;
  final bool isOval;
  final Color? backgroundColor;

  MutableCachedImage(
    this.url, {
    this.backgroundColor,
    this.shimmerColor,
    this.isOval = false,
    this.fit = BoxFit.cover,
  });

  @override
  State<MutableCachedImage> createState() => _MutableCachedImageState();
}

class _MutableCachedImageState extends State<MutableCachedImage> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  Widget generateOval(Widget w) => widget.isOval ? ClipOval(child: w) : w;

  @override
  Widget build(BuildContext context) {
    return generateOval(
      CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: kCachedImageLoadDuration),
        fadeInCurve: Curves.easeInQuad,
        fadeOutDuration: Duration(milliseconds: kCachedImageLoadDuration),
        placeholderFadeInDuration:
            Duration(milliseconds: kCachedImageLoadDuration),
        fadeOutCurve: Curves.easeInQuad,
        imageUrl: widget.url,
        fit: widget.fit,
        placeholder: (_, s) => MutableShimmer(
          animateToColor: widget.shimmerColor ?? kShimmerAnimationColor,
          child: generateOval(
            Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor ??
                    kColorMap[MutableColor.neutral10]!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
