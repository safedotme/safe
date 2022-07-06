import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final String hintText;

  MutableTextField({
    this.focusNode,
    this.hintText = "",
  });

  @override
  State<MutableTextField> createState() => _MutableTextFieldState();
}

class _MutableTextFieldState extends State<MutableTextField> {
  late Core core;
  late FocusNode node;
  Color cursorColor = Colors.white;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    node = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: core.utils.color.translucify(
        MutableColor.neutral5,
        Transparency.v64,
      ),
      cursorHeight: 18,
      focusNode: node,
      style: TextStyle(
        color: kColorMap[MutableColor.neutral1],
        fontFamily: kFontFamilyGen(weight: TypeWeight.medium),
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: kColorMap[MutableColor.neutral4],
          fontFamily: kFontFamilyGen(weight: TypeWeight.medium),
          fontSize: 16,
        ),
        fillColor: kColorMap[MutableColor.neutral8]!,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23),
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
