import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
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
                            vertical: 50, horizontal: kSideScreenMargin),
                        itemCount: 10,
                        separatorBuilder: (_, i) => Padding(
                          // Divider
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.red,
                          ),
                        ),
                        itemBuilder: (_, i) => Row(
                          children: [
                            MutableText(
                              "United States",
                              style: TypeStyle.body,
                            ),
                            SizedBox(width: 2),
                            MutableText(
                              "(+1)",
                              style: TypeStyle.body,
                              color: MutableColor.neutral2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: kSideScreenMargin,
                      ),
                      height: 35,
                      width: double.infinity,
                      color: Colors.blue.withOpacity(0.8),
                    ),
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
