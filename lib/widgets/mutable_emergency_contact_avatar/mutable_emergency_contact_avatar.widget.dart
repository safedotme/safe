import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableEmergencyContactAvatar extends StatelessWidget {
  final NotifiedContact contact;

  MutableEmergencyContactAvatar(this.contact);
  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return Container(
      height: kEmergencyContactAvatarSize,
      width: kEmergencyContactAvatarSize,
      decoration: BoxDecoration(
        color: kColorMap[MutableColor.neutral8],
        shape: BoxShape.circle,
        border: Border.all(
          width: 0.85,
          color: kColorMap[MutableColor.neutral7]!,
        ),
      ),
      child: Center(
        child: MutableText(
          core.utils.name.genInitials(contact.name),
          weight: TypeWeight.black,
          height: 1,
          size: 9,
          letterSpacing: LetterSpacingType.heading,
        ),
      ),
    );
  }
}
