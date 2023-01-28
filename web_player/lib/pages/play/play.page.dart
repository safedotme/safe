import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_page/mutable_page.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class PlayPage extends StatelessWidget {
  final String? incidentId;

  PlayPage(this.incidentId);
  @override
  Widget build(BuildContext context) {
    return MutablePage(
        body: Center(
      child: MutableText(
        incidentId ?? "404",
      ),
    ));
  }
}
