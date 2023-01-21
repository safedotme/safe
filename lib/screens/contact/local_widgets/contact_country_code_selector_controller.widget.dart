import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_country_code_selector/mutable_country_code_selector.widget.dart';

class ContactCountryCodeSelector extends StatefulWidget {
  @override
  State<ContactCountryCodeSelector> createState() =>
      _ContactCountryCodeSelectorState();
}

class _ContactCountryCodeSelectorState
    extends State<ContactCountryCodeSelector> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableCountryCodeSelector(
      controller: core.state.contact.countryCodeSelectorController,
      onPick: (code) {
        final contact = core.state.contact.editable!;

        final comps = contact.parsePhone();

        core.state.contact.setEditable(contact.copyWith(
          phone: "${code["dial_code"]} ${comps["phone"]}",
        ));

        core.state.contact.editorContactController.setValues(
          code: code["dial_code"],
        );
      },
    );
  }
}
