import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class VideoProgressIndicatorSkeleton extends StatelessWidget {
  final Widget? child;
  VideoProgressIndicatorSkeleton({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kLinearProgressIndicatorWidth,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(kLinearProgressIndicatorWidth),
      ),
      child: child,
    );
  }
}
