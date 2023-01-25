import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/screens/contact/local_widgets/contact_editing_action_sheet.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ContactTab extends StatefulWidget {
  final Contact contact;
  final void Function()? onEdit;
  ContactTab({
    required this.contact,
    this.onEdit,
  });

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
    return Observer(
      builder: (_) => Row(
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
          ),
          Spacer(),
          AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: core.state.contact.isEditing ? 1 : 0,
            curve: Curves.decelerate,
            child: MutableButton(
              onTap: () {
                if (!core.state.contact.isEditing) return;

                HapticFeedback.selectionClick();
                showCupertinoModalPopup(
                  context: context,
                  builder: (_) => ContactEditingActionSheet(
                    contact: widget.contact,
                    onEdit: widget.onEdit,
                  ),
                );
              },
              scale: 0.9,
              child: Container(
                height: 40,
                width: 40,
                color: Colors.transparent,
                alignment: Alignment.centerRight,
                child: MutableIcon(
                  MutableIcons.options,
                  size: Size(23, 23),
                  color: kColorMap[MutableColor.neutral3]!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
