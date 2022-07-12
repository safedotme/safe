import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableOtpInputPanel extends StatefulWidget {
  final PanelController controller;
  final void Function(String otp) onSubmit;

  MutableOtpInputPanel({
    required this.controller,
    required this.onSubmit,
  });

  @override
  State<MutableOtpInputPanel> createState() => _MutableOtpInputPanelState();
}

class _MutableOtpInputPanelState extends State<MutableOtpInputPanel>
    with TickerProviderStateMixin {
  late Core core;
  late PanelController controller;
  late ValueNotifier<double> notifier;
  late MediaQueryData queryData;
  FocusNode node = FocusNode();
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    controller = widget.controller;
  }

  // Gets height of ListView so it stays the same when keyboard is displayed (so keyboard doesn't overlay results)
  double? fetchListViewHeight() {
    if (key.currentContext != null) {
      final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;

      return box.size.height;
    }

    return null;
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
        onClosed: () {},
        maxHeight: value == 0
            ? kCountryCodeSelectorHeight // Refactor to new height
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
            ],
          ),
        ),
      ),
    );
  }
}
