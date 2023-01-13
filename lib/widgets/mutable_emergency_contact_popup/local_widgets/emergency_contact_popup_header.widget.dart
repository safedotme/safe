import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class EmergencyContactPopupHeader extends StatefulWidget {
  final String name;
  final String phone;
  final String code;
  final bool immutable;
  final Function()? onChange;
  final Function()? onCodeTap;

  EmergencyContactPopupHeader({
    required this.name,
    required this.phone,
    required this.code,
    this.immutable = false,
    this.onCodeTap,
    this.onChange,
  });

  @override
  State<EmergencyContactPopupHeader> createState() =>
      _EmergencyContactPopupHeaderState();
}

class _EmergencyContactPopupHeaderState
    extends State<EmergencyContactPopupHeader> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  void initControllers() {
    nameController = TextEditingController();

    phoneController = TextEditingController();
  }

  @override
  void initState() {
    super.initState();

    initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MutableEmergencyContactAvatar(
          widget.name,
          size: 65,
        ),
        SizedBox(height: 13),
        Visibility(
          visible: widget.immutable,
          child: MutableText(
            widget.name,
            weight: TypeWeight.heavy,
            selectable: true,
            size: 23,
          ),
        ),
        Visibility(
          child: TextField(
            controller: nameController,
            // style: MutableText(
            //   "",
            //   selectable: true,
            //   size: 18,
            //   color: MutableColor.neutral2,
            // ).generateTextStyle(),
          ),
        ),
        SizedBox(height: 6),
        Visibility(
          visible: widget.immutable,
          child: MutableText(
            "${widget.code} ${widget.phone}",
            selectable: true,
            size: 18,
            color: MutableColor.neutral2,
          ),
        ),
        Visibility(
          child: TextField(),
        ),
      ],
    );
  }
}
