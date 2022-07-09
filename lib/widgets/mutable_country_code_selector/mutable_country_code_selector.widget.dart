import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_country_code_selector/local_widgets/country_code.widget.dart';
import 'package:safe/widgets/mutable_country_code_selector/local_widgets/country_code_search_bar.widget.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableCountryCodeSelector extends StatefulWidget {
  final PanelController controller;

  MutableCountryCodeSelector({required this.controller});

  @override
  State<MutableCountryCodeSelector> createState() =>
      _MutableCountryCodeSelectorState();
}

class _MutableCountryCodeSelectorState
    extends State<MutableCountryCodeSelector> {
  @override
  Widget build(BuildContext context) {
    return MutablePopup(
      controller: widget.controller,
      defaultState: PanelState.CLOSED,
      minHeight: 0,
      maxHeight: 380,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          kHandleTopMargin,
          0,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: MutableHandle()),
            SizedBox(height: kPanelHandleToHeader),
            MutableText(
              "Country Codes",
              align: TextAlign.center,
              style: TypeStyle.h4,
              weight: TypeWeight.heavy,
            ),
            SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: Scrollbar(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: 50,
                          horizontal: kSideScreenMargin,
                        ),
                        itemCount: 10,
                        separatorBuilder: (_, i) => Padding(
                          // Divider
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: MutableDivider(),
                        ),
                        itemBuilder: (_, i) => CountryCode(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: CountryCodeSearchBar(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
