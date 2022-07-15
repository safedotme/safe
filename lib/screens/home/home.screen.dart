import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_safe_button/mutable_safe_button.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return MutableScaffold(
      overlays: [],
      body: Center(
        child: MutableSafeButton(),
      ),
    );
  }
}
