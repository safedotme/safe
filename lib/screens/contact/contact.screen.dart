import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/screens/contact/local_widgets/add_contact_button.widget.dart';
import 'package:safe/screens/contact/local_widgets/contact_tab.widget.dart';
import 'package:safe/screens/contact/local_widgets/contacts_screen_header.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late Core core;
  final key = GlobalKey();
  double height = 383;
  List<Contact>? local;
  bool tappedOut = true;

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

  void triggerFormat(List<Contact>? c) {
    if (c == local) return;
    local = c;

    // Trigger format
    if (local == null || local!.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MutablePopup(
      onClosed: () {
        if (tappedOut) core.utils.tutorial.handleOnLeave(core);
        core.state.contact.setIsEditing(false);
      },
      onOpened: () {
        tappedOut = true;
      },
      controller: core.state.contact.controller,
      minHeight: 0,
      maxHeight: height + kContactTopMargin + kContactBottomMargin,
      body: Observer(
        builder: (_) {
          triggerFormat(core.state.contact.contacts);
          return Padding(
            padding: EdgeInsets.fromLTRB(
              kSideScreenMargin,
              kContactTopMargin,
              kSideScreenMargin,
              kContactBottomMargin,
            ),
            child: core.state.contact.contacts == null ||
                    core.state.contact.contacts!.isEmpty
                ? SizedBox()
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        key: key,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(child: MutableHandle()),
                          SizedBox(height: 10),
                          ContactScreenHeader(),
                          SizedBox(height: 16),
                          ...List.generate(
                            (core.state.contact.contacts!.length * 2) - 1,
                            (i) {
                              if (i.isOdd) {
                                return SizedBox(height: 18);
                              }

                              return ContactTab(
                                contact: core.state.contact.contacts![i ~/ 2],
                                onEdit: () {
                                  tappedOut = false;
                                },
                              );
                            },
                          ),
                          SizedBox(height: 22),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AddContactButton(
                              onTap: () {
                                tappedOut = false;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
