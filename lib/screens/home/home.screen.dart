import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return MutableScaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              core.utils.auth.signOut();
            },
            child: Center(
              child: MutableText("Sign Out"),
            ),
          ),
        ),
      ),
    );
  }
}
