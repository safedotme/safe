import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';

class EnglargementBlurBackground extends StatefulWidget {
  @override
  State<EnglargementBlurBackground> createState() =>
      _EnglargementBlurBackgroundState();
}

class _EnglargementBlurBackgroundState
    extends State<EnglargementBlurBackground> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Visibility(
        visible: core.state.capture.enlargementState != 0,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8.0 * core.state.capture.enlargementState,
            sigmaY: 8.0 * core.state.capture.enlargementState,
          ),
          child: GestureDetector(
            onTap: () {
              core.state.capture.unEnlargeCameraView?.call();
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
