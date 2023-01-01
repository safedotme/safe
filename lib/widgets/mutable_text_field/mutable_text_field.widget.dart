import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class MutableTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType type;
  final Widget leadingLeft;
  final String hintText;
  final Widget leadingRight;
  final TextEditingController? controller;
  final void Function(String? value)? onChange;
  final void Function(String? value)? onSubmit;

  MutableTextField({
    required this.onChange,
    this.onSubmit,
    this.leadingRight = const SizedBox(),
    this.controller,
    this.leadingLeft = const SizedBox(),
    this.type = TextInputType.name,
    this.focusNode,
    this.hintText = "",
  });

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: kColorMap[MutableColor.neutral8]!,
        border: Border.all(
          color: kColorMap[MutableColor.neutral7]!,
          width: kBorderWidth,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          leadingLeft,
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: core.utils.color.translucify(
                MutableColor.neutral5,
                Transparency.v64,
              ),
              onChanged: onChange,

              // Height is based on fontSize (16)
              cursorHeight: 18,
              keyboardAppearance: kKeyboardAppearance,
              focusNode: focusNode,
              onSubmitted: onSubmit,
              style: kTextInputStyle,
              keyboardType: type,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: kTextInputStyle.copyWith(
                  color: kColorMap[MutableColor.neutral4],
                ),
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          leadingRight,
        ],
      ),
    );
  }
}
