import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/home/home.screen.dart';

class MutableAuthWrapper extends StatefulWidget {
  final Widget initial;
  final Widget home;

  MutableAuthWrapper({
    required this.initial,
    required this.home,
  });

  @override
  State<MutableAuthWrapper> createState() => _MutableAuthWrapperState();
}

class _MutableAuthWrapperState extends State<MutableAuthWrapper> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: core.utils.auth.userChanges,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data != null) {
            return widget.home;
          }

          return widget.initial;
        }

        return widget.initial;
      },
    );
  }
}
