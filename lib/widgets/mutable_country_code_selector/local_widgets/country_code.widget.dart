import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class CountryCode extends StatefulWidget {
  final Map<String, String> country;
  final void Function()? onTap;

  CountryCode(this.country, {this.onTap});

  @override
  State<CountryCode> createState() => _CountryCodeState();
}

class _CountryCodeState extends State<CountryCode> {
  GlobalKey parentKey = GlobalKey();
  GlobalKey codeKey = GlobalKey();
  double width = 0;

  @override
  void initState() {
    super.initState();

    // Waits for all keys to be attached
    Future.delayed(Duration.zero).then((timeStamp) {
      // Gets max width for country name based on width availability
      if (parentKey.currentContext != null && codeKey.currentContext != null) {
        RenderBox parentBox =
            parentKey.currentContext!.findRenderObject() as RenderBox;

        RenderBox codeBox =
            codeKey.currentContext!.findRenderObject() as RenderBox;

        setState(() {
          width = parentBox.size.width -
              codeBox.size.width -
              kCountryNameCodeSpacing;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        key: parentKey,
        padding: EdgeInsets.symmetric(vertical: 18),
        color: Colors.transparent,
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: width,
              ),
              child: MutableText(
                widget.country["name"] ??
                    core.utils.language.langMap[core.state.preferences
                        .language]!["country_code_selector"]["load_error"],
                overflow: TextOverflow.ellipsis,
                style: TypeStyle.body,
              ),
            ),
            SizedBox(width: kCountryNameCodeSpacing),
            SizedBox(
              key: codeKey,
              child: MutableText(
                widget.country["dial_code"] ?? "",
                style: TypeStyle.body,
                color: MutableColor.neutral2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
