import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/contact/local_widgets/actively_editing_indicator.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ContactScreenHeader extends StatefulWidget {
  @override
  State<ContactScreenHeader> createState() => _ContactScreenHeaderState();
}

class _ContactScreenHeaderState extends State<ContactScreenHeader> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: MutableText(
            "Contacts", //TODO: Extract
            weight: TypeWeight.heavy,
            size: 18,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: MutableButton(
            scale: 0.9,
            onTap: () {
              HapticFeedback.lightImpact();
              core.state.contact.setIsEditing(!core.state.contact.isEditing);
            },
            child: Container(
              height: 30,
              width: 40,
              color: Colors.transparent,
              alignment: Alignment.topRight,
              child: ActivelyEditingIndicator(),
            ),
          ),
        )
      ],
    );
  }
}
