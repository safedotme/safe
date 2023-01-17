import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/local_widgets/emergency_contact_popup_header.widget.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableEmergencyContactPopup extends StatefulWidget {
  final Widget body;
  final EmergencyContactPopupController? controller;
  final PanelController? panelController;
  final bool immutable;
  final double? height;
  final Function(String s)? onNameChange;
  final Function(String p)? onPhoneChange;

  MutableEmergencyContactPopup({
    this.body = const SizedBox(),
    this.panelController,
    this.onNameChange,
    this.height,
    this.controller,
    this.onPhoneChange,
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
        controller: widget.panelController,
        onClosed: () {
          controller.unfocus(true);
          controller.unfocus(false);
        },
        style: MutablePopupStyle(
          backgroundColor: kColorMap[kInputPopupColor],
        ),
        type: PopupType.input,
        bottomInsets: value,
        backdropTapClose: true,
        height: widget.height,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            18,
            kTopInputPopupMargin,
            kBottomInputPopupMargin,
            20,
          ),
          child: Column(
            children: [
              EmergencyContactPopupHeader(
                controller: controller,
                immutable: widget.immutable,
                onNameChange: (name) {
                  widget.onNameChange?.call(name);
                },
                onPhoneChange: (phone) {
                  widget.onPhoneChange?.call(phone);
                },
              ),
              widget.body,
            ],
          ),
        ),
      ),
    );
  }
}