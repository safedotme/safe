import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';

class PlayBody extends StatefulWidget {
  @override
  State<PlayBody> createState() => _PlayBodyState();
}

class _PlayBodyState extends State<PlayBody> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
