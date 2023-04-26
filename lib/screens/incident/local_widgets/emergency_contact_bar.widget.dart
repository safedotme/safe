import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class EmergencyContactBar extends StatefulWidget {
  final NotifiedContact contact;
  final Function(NotifiedContact contact)? onTap;

  EmergencyContactBar(this.contact, {this.onTap});

  @override
  State<EmergencyContactBar> createState() => _EmergencyContactBarState();
}

class _EmergencyContactBarState extends State<EmergencyContactBar> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: () {
        widget.onTap?.call(widget.contact);
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            MutableEmergencyContactAvatar(widget.contact.name),
            SizedBox(width: 6),
            MutableText(widget.contact.name, size: 18),
            Spacer(),
            MutableIcon(
              MutableIcons.caretRight,
              size: Size(8, 14),
              color: kColorMap[MutableColor.neutral3]!,
            ),
            SizedBox(width: 5)
          ],
        ),
      ),
    );
  }
}
