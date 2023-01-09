import 'package:flutter/material.dart';
import 'package:safe/screens/incident/local_widgets/data_point_key.widget.dart';
import 'package:safe/screens/incident/local_widgets/data_point_wrapper.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class DataPointBox extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: onTap,
      child: DataPointWrapper(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 114),
          child: Padding(
            padding: const EdgeInsets.all(kIncidentDataBoxPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataPointKey(keyIcon, keyText),
                        SizedBox(height: 10),
                        MutableText(
                          header,
                          weight: TypeWeight.bold,
                          decoration: TextDecoration.none,
                          size: 18,
                        ),
                        SizedBox(height: 5),
                        MutableText(
                          subheader,
                          size: 14,
                          color: MutableColor.neutral2,
                          decoration: TextDecoration.none,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: sideWidget == null ? 0 : 10),
                sideWidget == null ? SizedBox() : sideWidget!,
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
