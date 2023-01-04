import 'package:flutter/material.dart';
import 'package:safe/screens/incident/local_widgets/data_point_wrapper.widget.dart';

class IncidentDownloadBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataPointWrapper(
      child: Row(
        children: [Image.asset("assets/images/download.png")],
      ),
    );
  }
}
