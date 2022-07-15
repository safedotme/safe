import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_country_code_selector/mutable_country_code_selector.widget.dart';

class AuthCountryCodeSelector extends StatefulWidget {
  @override
  State<AuthCountryCodeSelector> createState() =>
      _AuthCountryCodeSelectorState();
}

class _AuthCountryCodeSelectorState extends State<AuthCountryCodeSelector> {
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
          core.state.auth.setCountryDialCode(country["dial_code"]!);
          core.state.auth.setCountryCode(country["code"]!);
          if (core.state.auth.onPick != null) {
            // Formats text
            core.state.auth.onPick!(
              core.state.auth.phoneNumber,
            );
          }
        },
        controller: core.state.auth.countryCodeController,
      ),
    );
  }
}
