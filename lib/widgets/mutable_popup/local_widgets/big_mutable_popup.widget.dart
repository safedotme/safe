import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BigMutablePopup extends StatelessWidget {
  const BigMutablePopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panel: Center(
        child: Text("This is the sliding Widget"),
      ),
      body: Center(
        child: Text("This is the Widget behind the sliding panel"),
      ),
    );
  }
}
