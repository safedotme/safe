import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_country_code_selector/mutable_country_code_selector.widget.dart';

class SignupCountryCodeSelector extends StatefulWidget {
  @override
  State<SignupCountryCodeSelector> createState() =>
      _SignupCountryCodeSelectorState();
}

class _SignupCountryCodeSelectorState extends State<SignupCountryCodeSelector> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableCountryCodeSelector(
        onPick: (country) {
          core.state.signup.setCountryDialCode(country["dial_code"]!);
          core.state.signup.setCountryCode(country["code"]!);
          if (core.state.signup.onPick != null) {
            // Formats text
            core.state.signup.onPick!(
              core.state.signup.phoneNumber,
            );
          }
        },
        controller: core.state.signup.countryCodeController,
      ),
    );
  }
}
