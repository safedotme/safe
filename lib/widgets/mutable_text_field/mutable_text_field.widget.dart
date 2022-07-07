import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType type;
  final String hintText;
  final void Function(String? value)? onChange;
  final void Function(String? value)? onSubmit;

  MutableTextField({
    required this.onChange,
    this.onSubmit,
    this.type = TextInputType.name,
    this.focusNode,
    this.hintText = "",
  });

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of(context, listen: false);

    return TextField(
      cursorColor: core.utils.color.translucify(
        MutableColor.neutral5,
        Transparency.v64,
      ),
      onChanged: onChange,

      // Height is based on fontSize (16)
      cursorHeight: 18,
      focusNode: focusNode,
      onSubmitted: onSubmit,
      style: kTextInputStyle,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: kTextInputStyle.copyWith(
          color: kColorMap[MutableColor.neutral4],
        ),
        fillColor: kColorMap[MutableColor.neutral8]!,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: kColorMap[MutableColor.neutral7]!,
            width: kBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: kColorMap[MutableColor.neutral7]!,
            width: kBorderWidth,
          ),
        ),
      ),
    );
  }
}
