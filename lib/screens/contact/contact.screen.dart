import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/contact/local_widgets/add_contact_button.widget.dart';
import 'package:safe/screens/contact/local_widgets/contact_tab.widget.dart';
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
  late Core core;
  final key = GlobalKey();
  double height = 383;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchHeight();
    });
  }

  void fetchHeight() {
    if (key.currentContext == null) return;

    final box = key.currentContext!.findRenderObject() as RenderBox?;

    if (box == null) return;

    setState(() {
      setState(() {
        height = box.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MutablePopup(
      defaultState: PanelState.OPEN, // TODO: Change me
      minHeight: 0,
      maxHeight: height + kContactTopMargin + kContactBottomMargin,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          kSideScreenMargin,
          kContactTopMargin,
          kSideScreenMargin,
          kContactBottomMargin,
        ),
        child: Center(
          child: Column(
            key: key,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: MutableHandle()),
              SizedBox(height: 10),
              ContactScreenHeader(),
              SizedBox(height: 22),
              ...List.generate(
                (core.state.contact.contacts!.length * 2) - 1,
                (index) {
                  if (index.isOdd) {
                    return SizedBox(height: 18);
                  }

                  return ContactTab(
                    core.state.contact
                        .contacts![core.state.contact.contacts!.length ~/ 2],
                  );
                },
              ),
              SizedBox(height: 22),
              Align(
                alignment: Alignment.centerLeft,
                child: AddContactButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}