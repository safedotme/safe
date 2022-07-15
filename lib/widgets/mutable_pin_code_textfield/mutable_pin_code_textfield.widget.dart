import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutablePinCodeTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final int length;
  final void Function(String code) onChanged;
  final void Function(String code)? onComplete;

  MutablePinCodeTextField({
    this.focusNode,
    this.length = 6,
    this.controller,
    required this.onChanged,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: PinCodeTextField(
        controller: controller,
        keyboardType: TextInputType.number,
        animationType: AnimationType.none,
        keyboardAppearance: kKeyboardAppearance,
        textStyle: TextStyle(
          color: kColorMap[MutableColor.neutral1],
          fontFamily: kFontFamilyGen(weight: TypeWeight.heavy),
          fontSize: 20,
        ),
        pinTheme: PinTheme(
          fieldWidth: 45,
          // ACTIVE
          activeColor: kColorMap[MutableColor.neutral7],
          activeFillColor: kColorMap[MutableColor.neutral8],
          // SELECTED
          selectedColor: kColorMap[MutableColor.neutral6],
          selectedFillColor: kColorMap[MutableColor.neutral7],
          //INACTIVE
          inactiveColor: kColorMap[MutableColor.neutral7],
          inactiveFillColor: kColorMap[MutableColor.neutral8],
          borderWidth: kBorderWidth,
          borderRadius: BorderRadius.circular(12),
          shape: PinCodeFieldShape.box,
        ),
        enableActiveFill: true,
        showCursor: false,
        focusNode: focusNode,
        appContext: context,
        length: length,
        onCompleted: onComplete,
        onChanged: onChanged,
      ),
    );
  }
}
