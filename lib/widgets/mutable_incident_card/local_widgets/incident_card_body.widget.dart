import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentCardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MutableText(
                  "Incident Name",
                  style: TypeStyle.h5,
                  weight: TypeWeight.bold,
                ),
                SizedBox(height: 5),
                MutableText(
                  "One Apple Park Way, Cupertino, CA 95014, United States",
                  style: TypeStyle.body,
                  color: MutableColor.neutral2,
                ),
                SizedBox(height: 5),
                SizedBox(),
              ],
            ),
          ),
          SizedBox(width: 10),
          MutablePill(
            text: "Secured",
            icon: MutableIcons.key,
          )
        ],
      ),
    );
  }
}
