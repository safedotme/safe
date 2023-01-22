import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/phone/codes.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class EmergencyContactPopupHeader extends StatefulWidget {
  final bool immutable;
  final Function(String s) onNameChange;
  final Function(String s) onPhoneChange;
  final Function()? onCodeTap;
  final EmergencyContactPopupController? controller;
  final bool showInitials;

  EmergencyContactPopupHeader({
    this.controller,
    this.immutable = false,
    this.showInitials = true,
    this.onCodeTap,
    required this.onNameChange,
    required this.onPhoneChange,
  });

  @override
  State<EmergencyContactPopupHeader> createState() =>
      _EmergencyContactPopupHeaderState();
}

class _EmergencyContactPopupHeaderState
    extends State<EmergencyContactPopupHeader> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late Core core;
  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();

  // STATE
  String name = "";
  String phone = "";
  String code = kDefaultCountryCode;
  bool isPhoneEmpty = false;

  // Used only to determine size of phone textfield
  late int phoneLen;

  void reset() {
    phoneController.text = "";
    formatPhone(kDefaultCountryCode, "");
  }

  void triggerFormat(String code) {
    formatPhone(code, phoneController.text);
  }

  void unfocus(bool name) {
    if (name) {
      nameNode.unfocus();
      return;
    }

    phoneNode.unfocus();
  }

  void focus(bool name) {
    if (name) {
      nameNode.requestFocus();
      return;
    }

    phoneNode.requestFocus();
  }

  Future<void> handleEmptyPhone(Map country, String ph) async {
    final formatted = await core.utils.phone.format(
      core.utils.phone.generateHint(country["code"]!),
      code,
    );

    setState(() {
      phoneLen = "(${country["dial_code"]}) $formatted".length;
      phone = formatted;
      isPhoneEmpty = true;
      code = country["dial_code"]!;
    });
  }

  void formatPhone(String code, String ph) async {
    Map? country;

    try {
      country =
          kCountryCodes.where((element) => element["dial_code"] == code).first;
    } catch (e) {
      throw "Unable to find dial code $code";
    }

    if (ph.isEmpty) {
      handleEmptyPhone(country, ph);
      return;
    }

    var formattedPhone = await core.utils.phone.format(
      core.utils.text.removeSymbols(ph),
      country["code"],
    );

    setState(() {
      phoneLen = "($code) $formattedPhone".length;
      this.code = code;
      isPhoneEmpty = false;
      phone = formattedPhone;
    });

    phoneController.text = formattedPhone;

    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
  }

  // STYLE
  TextStyle phoneStyle = MutableText.generateTextStyle(
    size: 18,
    color: MutableColor.neutral2,
  );

  TextStyle nameStyle = MutableText.generateTextStyle(
    size: 18,
    color: MutableColor.neutral2,
  );

  void initControllers() {
    nameController = TextEditingController();

    nameController.text = name;

    phoneController = TextEditingController();

    phoneController.text = phone;
  }

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    if (widget.controller != null) {
      widget.controller!.setState(this);
    }

    initControllers();
    formatPhone(code, phone);
  }

  String generateHint() {
    String countryCode = kCountryCodes
        .where((element) => element["dial_code"] == code)
        .toList()
        .first["code"]!;

    String formatted = core.utils.phone.generateHint(countryCode);

    return formatted;
  }

  double genPhoneLength(String phone) {
    double count = 0;

    for (int i = 0; i < phone.length; i++) {
      switch (phone[i]) {
        case "0":
          count += 11;
          break;
        case "1":
          count += 8.5;
          break;
        case "2":
          count += 10.5;
          break;
        case "3":
          count += 11;
          break;
        case "4":
          count += 11;
          break;
        case "5":
          count += 11;
          break;
        case "6":
          count += 11;
          break;
        case "7":
          count += 10;
          break;
        case "8":
          count += 11;
          break;
        case "9":
          count += 11;
          break;
        case "(":
          count += 6.7;
          break;
        case ")":
          count += 6;
          break;
        case "+":
          count += 11;
          break;
        case "-":
          count += 8;
          break;
        case " ":
          count += 4.1;
          break;
      }
    }

    return count;
  }

  void setValues({
    String? name,
    String? phone,
    String? code,
  }) {
    setState(() {
      this.name = name ?? this.name;
      nameController.text = name ?? nameController.text;
      formatPhone(code ?? this.code, phone ?? (isPhoneEmpty ? "" : this.phone));
    });
  }

  double genPadding(double width) {
    double space = 0;

    if (phone == "") {
      String formatted = generateHint();

      formatted = "($code) $formatted";
      space = width - genPhoneLength(formatted);
    } else {
      space = width - genPhoneLength("($code) $phone");
    }

    if (space.isNegative) return 0;
    return space / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Visibility(
          visible: widget.showInitials,
          child: MutableEmergencyContactAvatar(
            name,
            size: kEmergencyContactAvatarPopupSize,
          ),
        ),
        SizedBox(height: 13),
        Theme(
          data: ThemeData.dark(),
          child: TextField(
            controller: nameController,
            focusNode: nameNode,
            onChanged: (s) {
              widget.onNameChange(s);
              setState(() {
                name = s;
              });
            },
            onSubmitted: (_) {
              if (!isPhoneEmpty) return;
              phoneNode.requestFocus();
            },
            readOnly: widget.immutable,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: core.utils.language
                      .langMap[core.state.preferences.language]!["widgets"]
                  ["emergency_contacts_popup"]["no_name_hint_text"],
              hintStyle: MutableText.generateTextStyle(
                weight: TypeWeight.semiBold,
                size: 23,
                color: MutableColor.neutral4,
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            textAlign: TextAlign.center,
            cursorColor: kColorMap[MutableColor.neutral4],
            style: MutableText.generateTextStyle(
              weight: TypeWeight.heavy,
              size: 23,
            ),
          ),
        ),
        SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: EdgeInsets.only(
              left: genPadding(constraints.maxWidth),
            ),
            child: Row(
              children: [
                MutableButton(
                  onTap: widget.onCodeTap,
                  child: MutableText(
                    "($code)",
                    overrideStyle: phoneStyle.copyWith(
                      color: kColorMap[isPhoneEmpty
                          ? MutableColor.neutral5
                          : MutableColor.neutral2],
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Theme(
                    data: ThemeData.dark(),
                    child: TextField(
                      focusNode: phoneNode,
                      controller: phoneController,
                      readOnly: widget.immutable,
                      onChanged: (s) {
                        formatPhone(code, s);
                        widget.onPhoneChange(s);
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintStyle: phoneStyle.copyWith(
                          color: kColorMap[isPhoneEmpty
                              ? MutableColor.neutral5
                              : MutableColor.neutral2],
                        ),
                        hintText: generateHint(),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                      cursorColor: kColorMap[MutableColor.neutral4],
                      style: phoneStyle.copyWith(
                        color: kColorMap[phone == ""
                            ? MutableColor.neutral5
                            : MutableColor.neutral2],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EmergencyContactPopupController {
  _EmergencyContactPopupHeaderState? _state;

  // ignore: library_private_types_in_public_api
  void setState(_EmergencyContactPopupHeaderState s) => _state = s;

  bool get isAttached => _state != null;

  /// [name] refers to unfocusing the name keyboard
  void unfocus(bool name) {
    assert(_state != null, "Controller has not been attached");

    _state!.unfocus(name);
  }

  void focus(bool name) {
    assert(_state != null, "Controller has not been attached");

    _state!.focus(name);
  }

  void triggerFormat(String code) {
    assert(_state != null, "Controller has not been attached");

    _state!.triggerFormat(code);
  }

  void reset() {
    assert(_state != null, "Controller has not been attached");

    _state!.reset();
  }

  void setValues({
    String? name,
    String? phone,
    String? code,
  }) {
    assert(_state != null, "Controller has not been attached");

    _state!.setValues(name: name, phone: phone, code: code);
  }
}
