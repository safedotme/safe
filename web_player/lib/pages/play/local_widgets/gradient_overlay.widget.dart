import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class GradientOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    return Positioned(
      bottom: 0,
      child: Container(
        height: 125,
        width: queryData.size.width,
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
      ),
    );
  }
}
