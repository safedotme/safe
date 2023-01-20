import 'package:flutter/material.dart';
import 'package:safe/screens/contact/local_widgets/contacts_screen_header.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return MutablePopup(
      defaultState: PanelState.OPEN, // TODO: Change me
      minHeight: 0,
      maxHeight: 383,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          kSideScreenMargin,
          8,
          kSideScreenMargin,
          56,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MutableHandle(),
            SizedBox(height: 10),
            ContactScreenHeader()
          ],
        ),
      ),
    );
  }
}
