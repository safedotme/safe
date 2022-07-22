import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';

class MutableCaptureControlBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCaptureControlBoxHeight,
      decoration: BoxDecoration(
        color: kColorMap[MutableColor.neutral9],
        borderRadius: BorderRadius.circular(kMainPopupBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MutableHandle(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(color: Colors.red),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(color: Colors.blue),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
