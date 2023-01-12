import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Core core = Provider.of(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MutableText(
            core.utils.language.langMap[core.state.preferences.language]![
                "country_code_selector"]["country_not_found"]["header"],
            style: TypeStyle.h4,
            weight: TypeWeight.bold,
            align: TextAlign.center,
          ),
          MutableButton(
            onTap: () {
              // TODO: Log request country code to logsnag
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MutableText(
                  core.utils.language.langMap[core.state.preferences.language]![
                      "country_code_selector"]["country_not_found"]["desc"][0],
                  style: TypeStyle.body,
                  color: MutableColor.neutral2,
                  align: TextAlign.center,
                ),
                MutableText(
                  core.utils.language.langMap[core.state.preferences.language]![
                      "country_code_selector"]["country_not_found"]["desc"][1],
                  style: TypeStyle.body,
                  color: MutableColor.neutral2,
                  align: TextAlign.center,
                  decoration: TextDecoration.underline,
                ),
                MutableText(
                  core.utils.language.langMap[core.state.preferences.language]![
                      "country_code_selector"]["country_not_found"]["desc"][2],
                  style: TypeStyle.body,
                  color: MutableColor.neutral2,
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
