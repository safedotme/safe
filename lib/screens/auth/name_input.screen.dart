import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';

class NameInputScreen extends StatefulWidget {
  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  late Core core;
  late MediaQueryData queryData;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - 42,
      controller: core.state.signup.nameInputController,
      body: SizedBox.expand(),
    );
  }
}
