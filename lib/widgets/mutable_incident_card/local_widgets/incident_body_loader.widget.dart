import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class IncidentBodyLoader extends StatelessWidget {
  final double width;
  final double height;

  IncidentBodyLoader(this.width, {this.height = 16.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.3),
        color: kColorMap[MutableColor.neutral8],
      ),
    );
  }
}
