import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class TimelineCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kContactTimelineWidth,
      width: kContactTimelineWidth,
      decoration: BoxDecoration(
        color: Color(0xffE6E6E6),
        shape: BoxShape.circle,
      ),
    );
  }
}
