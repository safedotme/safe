import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_loader/mutable_loader.widget.dart';
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';

class AuthLoader extends StatefulWidget {
  @override
  State<AuthLoader> createState() => _AuthLoaderState();
}

class _AuthLoaderState extends State<AuthLoader> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableOverlay(
      controller: core.state.auth.overlayController,
      child: Center(
        child: MutableLoader(
          text: "Creating account", // Change this
        ),
      ),
    );
  }
}
