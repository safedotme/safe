import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/local_widgets/emergency_contact_popup_header.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableEmergencyContactPopup extends StatefulWidget {
  final Widget body;
  final String name;
  final String phone;
  final String code;
  final EmergencyContactPopupController? controller;
  final bool immutable;
  final Function(String s) onNameChange;
  final Function(String p) onPhoneChange;

  MutableEmergencyContactPopup({
    this.body = const SizedBox(),
    required this.name,
    required this.phone,
    required this.code,
    required this.onNameChange,
    this.controller,
    required this.onPhoneChange,
    this.immutable = false,
  });

  @override
  State<MutableEmergencyContactPopup> createState() =>
      _MutableEmergencyContactPopupState();
}

class _MutableEmergencyContactPopupState
    extends State<MutableEmergencyContactPopup> {
  late ValueNotifier<double> bottomInsetsNotifier;
  late EmergencyContactPopupController controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = EmergencyContactPopupController();
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    bottomInsetsNotifier =
        ValueNotifier<double>(mediaQueryData.viewInsets.bottom);

    return ValueListenableBuilder<double>(
      valueListenable: bottomInsetsNotifier,
      builder: (context, value, _) => MutablePopup(
        onClosed: () {
          controller.unfocus(true);
          controller.unfocus(false);
        },
        type: PopupType.input,
        bottomInsets: value,
        defaultState: PanelState.OPEN,
        backdropTapClose: true,
        body: Padding(
          padding: EdgeInsets.fromLTRB(18, 26, 18, 20),
          child: Column(
            children: [
              EmergencyContactPopupHeader(
                controller: controller,
                name: widget.name,
                phone: widget.phone,
                code: widget.code,
                immutable: widget.immutable,
                onNameChange: widget.onNameChange,
                onPhoneChange: widget.onPhoneChange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
