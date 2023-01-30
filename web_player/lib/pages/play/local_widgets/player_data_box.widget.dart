import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class PlayerDataBox extends StatelessWidget {
  final String value;
  final String header;
  final MutableIcon icon;

  PlayerDataBox({
    required this.value,
    required this.header,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kColorMap[MutableColor.neutral8]!.withOpacity(0.8),
        border: Border.all(
          width: kBorderWidth,
          color: Colors.white.withOpacity(0.15),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              SizedBox(width: 3),
              MutableText(
                header.toUpperCase(),
                color: MutableColor.neutral3,
                weight: TypeWeight.semiBold,
                size: 12,
              ),
            ],
          ),
          SizedBox(height: 4),
          MutableText(
            value.toUpperCase(),
            weight: TypeWeight.bold,
            size: 12,
            color: MutableColor.neutral2,
          ),
        ],
      ),
    );
  }
}
