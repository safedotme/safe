import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/phone/codes.util.dart';
import 'package:safe/widgets/mutable_country_code_selector/local_widgets/country_code.widget.dart';
import 'package:safe/widgets/mutable_country_code_selector/local_widgets/country_code_search_bar.widget.dart';
import 'package:safe/widgets/mutable_country_code_selector/local_widgets/country_not_found.widget.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_scrollbar/mutable_scrollbar.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableCountryCodeSelector extends StatefulWidget {
  final PanelController controller;
  final void Function(Map<String, String> pick) onPick;

  MutableCountryCodeSelector({
    required this.controller,
    required this.onPick,
  });

  @override
  State<MutableCountryCodeSelector> createState() =>
      _MutableCountryCodeSelectorState();
}

class _MutableCountryCodeSelectorState extends State<MutableCountryCodeSelector>
    with TickerProviderStateMixin {
  late Core core;
  late PanelController controller;
  late TextEditingController searchController;
  late ValueNotifier<double> notifier;
  late MediaQueryData queryData;
  FocusNode node = FocusNode();
  GlobalKey key = GlobalKey();
  late List<Map<String, String>> result;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    result = kCountryCodes;
    controller = widget.controller;
    searchController = TextEditingController();
  }

  // Gets height of ListView so it stays the same when keyboard is displayed (so keyboard doesn't overlay results)
  double? fetchListViewHeight() {
    if (key.currentContext != null) {
      final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;

      return box.size.height;
    }

    return null;
  }

  void handlePick(Map<String, String> pick) {
    node.unfocus();
    controller.close();
    widget.onPick(pick);
  }

  void handleSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        result = kCountryCodes;
      });

      return;
    }

    List<Map<String, String>> resp = core.utils.phone.searchCountry(query);

    if (resp.isEmpty) {
      setState(() {
        result = [];
      });
      return;
    }

    setState(() {
      result = resp;
    });
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    notifier = ValueNotifier(queryData.viewInsets.bottom);

    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, value, _) => MutablePopup(
        controller: controller,
        defaultState: PanelState.CLOSED,
        minHeight: 0,
        onClosed: () {
          node.unfocus();

          // Resets search for next session
          searchController.text = "";
          handleSearch("");
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
                core.utils.language.langMap[core.state.preferences.language]![
                    "country_code_selector"]["header"],
                align: TextAlign.center,
                style: kCountryCodeHeaderStyle,
                weight: kCountryCodeHeaderWeight,
              ),
              SizedBox(height: kCountryCodeHeaderToBody),
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      height:
                          value != 0 ? fetchListViewHeight() : double.infinity,
                      key: key,
                      child: result.isNotEmpty
                          ? MutableScrollBar(
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(
                                  vertical: 32,
                                  horizontal: kSideScreenMargin,
                                ),
                                itemCount: result.length,
                                separatorBuilder: (_, i) => MutableDivider(),
                                itemBuilder: (_, i) => CountryCode(
                                  result[i],
                                  onTap: () {
                                    handlePick(result[i]);
                                  },
                                ),
                              ),
                            )
                          : CountryNotFound(),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CountryCodeSearchBar(
                        controller: searchController,
                        node: node,
                        onChange: handleSearch,
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
