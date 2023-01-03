import 'package:flutter/material.dart';
import 'package:safe/screens/incident/local_widgets/data_point_key.widget.dart';
import 'package:safe/screens/incident/local_widgets/data_point_wrapper.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

import '../../../widgets/mutable_icon/mutable_icon.widget.dart';

class DataPointBox extends StatefulWidget {
  final String header;
  final String subheader;
  final Widget? sideWidget;
  final MutableIcon keyIcon;
  final String keyText;
  final Function()? onTap;

  DataPointBox({
    required this.header,
    required this.subheader,
    required this.keyIcon,
    required this.keyText,
    this.sideWidget,
    this.onTap,
  });

  @override
  State<DataPointBox> createState() => _DataPointBoxState();
}

class _DataPointBoxState extends State<DataPointBox> {
  @override
  Widget build(BuildContext context) {
    return DataPointWrapper(
      child: SizedBox(
        height: 114,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataPointKey(widget.keyIcon, widget.keyText),
                    SizedBox(height: 10),
                    MutableText(
                      widget.header,
                      weight: TypeWeight.bold,
                      size: 18,
                    ),
                    SizedBox(height: 5),
                    MutableText(
                      widget.subheader,
                      size: 14,
                      color: MutableColor.neutral2,
                    ),
                  ],
                ),
              ),
              widget.sideWidget == null
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: widget.sideWidget,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
