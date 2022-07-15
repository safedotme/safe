import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';

class IncidentLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MutablePopup(
      body: Container(),
      minHeight: kIncidentLogMinPopupHeight,
    );
  }
}
