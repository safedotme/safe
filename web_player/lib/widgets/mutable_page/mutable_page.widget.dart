import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutablePage extends StatelessWidget {
  final Widget body;

  MutablePage({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorMap[MutableColor.neutral10],
      body: SelectionArea(child: body),
    );
  }
}
