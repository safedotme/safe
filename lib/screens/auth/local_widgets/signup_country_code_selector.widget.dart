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
        controller: core.state.signup.countryCodeController,
      ),
    );
  }
}
