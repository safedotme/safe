import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class TestingScreen extends StatefulWidget {
  static const String id = "testing_screen";

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return MutableScaffold(
      body: Center(
        child: MutableText("hello world"),
      ),
    );
  }
}
