import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ActivelyEditingIndicator extends StatefulWidget {
  @override
  State<ActivelyEditingIndicator> createState() =>
      _ActivelyEditingIndicatorState();
}

class _ActivelyEditingIndicatorState extends State<ActivelyEditingIndicator> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => core.state.contact.isEditing
          ? ShaderMask(
              shaderCallback: (rect) => LinearGradient(
                colors: kPrimaryGradientColors.sublist(
                  1,
                  kPrimaryGradientColors.length - 1,
                ),
              ).createShader(rect),
              child: MutableText(
                core.utils.language
                        .langMap[core.state.preferences.language]!["contact"]
                    ["edit_button"]["done"],
                weight: TypeWeight.bold,
              ),
            )
          : MutableText(
              core.utils.language
                      .langMap[core.state.preferences.language]!["contact"]
                  ["edit_button"]["edit"],
              color: MutableColor.neutral3,
              weight: TypeWeight.bold,
            ),
    );
  }
}
