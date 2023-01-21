import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ContactTab extends StatefulWidget {
  final Contact contact;
  ContactTab(this.contact);

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MutableEmergencyContactAvatar(
          widget.contact.name,
          size: 40,
        ),
        SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MutableText(
              widget.contact.name,
              weight: TypeWeight.semiBold,
            ),
            SizedBox(height: 3),
            MutableText(
              widget.contact.phone,
              size: 14,
              weight: TypeWeight.regular,
              color: MutableColor.neutral2,
            ),
          ],
        )
      ],
    );
  }
}
