import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class CountryCodeSearchBar extends StatelessWidget {
  final void Function(String query) onChange;
  final FocusNode? node;

  CountryCodeSearchBar({required this.onChange, this.node});

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kSideScreenMargin,
      ),
      height: 35, // Extact
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kColorMap[MutableColor.neutral9]!,
            kColorMap[MutableColor.neutral9]!.withOpacity(0),
          ],
          stops: [
            0.5,
            1,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35 / 2),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: TextField(
            focusNode: node,
            cursorColor: core.utils.color.translucify(
              MutableColor.neutral5,
              Transparency.v64,
            ),
            onChanged: onChange,
            keyboardAppearance: kKeyboardAppearance,
            style: kTextInputStyle,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: core.utils.language.langMap[core.state.preferences
                  .language]!["country_code_selector"]["search_hint"],
              hintStyle: kTextInputStyle.copyWith(
                color: kColorMap[MutableColor.neutral4],
              ),
              fillColor: core.utils.color.translucify(
                MutableColor.neutral8,
                Transparency.v64,
              ),
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
          ),
        ),
      ),
    );
  }
}
