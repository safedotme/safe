import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableLoader extends StatelessWidget {
  final String text;

  MutableLoader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: kColorMap[MutableColor.iosGrey],
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 20,
            cornerSmoothing: kCornerSmoothing,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(color: Colors.white),
          SizedBox(width: 10),
          MutableText(
            "$text...",
            style: TypeStyle.h4,
            weight: TypeWeight.semiBold,
          ),
        ],
      ),
    );
  }
}
