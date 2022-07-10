import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
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

class _MutableCountryCodeSelectorState extends State<MutableCountryCodeSelector>
    with TickerProviderStateMixin {
  late Core core;
  late ValueNotifier<double> notifier;
  late MediaQueryData queryData;
  FocusNode node = FocusNode();
  GlobalKey key = GlobalKey();
  late List<Map<String, String>> result;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    result = core.utils.countryCode.display();
  }

  // Gets height of ListView so it stays the same when keyboard is displayed (so keyboard doesn't overlay results)
  double? fetchListViewHeight() {
    if (key.currentContext != null) {
      final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;

      return box.size.height;
    }

    return null;
  }

  void handleSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        result = core.utils.countryCode.display();
      });

      return;
    }

    List<Map<String, String>> resp = core.utils.countryCode.search(query);

    if (resp.isEmpty) {
      // Show empty state

      return;
    }

    setState(() {
      result = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    notifier = ValueNotifier(queryData.viewInsets.bottom);

    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, value, _) => MutablePopup(
        controller: widget.controller,
        defaultState: PanelState.CLOSED,
        minHeight: 0,
        onClosed: () {
          node.unfocus();
        },
        maxHeight: value == 0
            ? kCountryCodeSelectorHeight
            : (kCountryCodeSelectorHeight + value),
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
                    SizedBox(
                      height:
                          value != 0 ? fetchListViewHeight() : double.infinity,
                      key: key,
                      child: Scrollbar(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: kSideScreenMargin,
                          ),
                          itemCount: result.length,
                          separatorBuilder: (_, i) => Padding(
                            // Divider
                            padding: EdgeInsets.symmetric(vertical: 18),
                            child: MutableDivider(),
                          ),
                          itemBuilder: (_, i) => CountryCode(result[i]),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CountryCodeSearchBar(
                        node: node,
                        onChange: (query) {
                          handleSearch(query);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
