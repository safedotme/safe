import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableSettingsBlock extends StatelessWidget {
  final String header;
  final List<SettingsBlockItem> items;

  MutableSettingsBlock({required this.header, required this.items});

  List<Widget> generateItems() {
    List<Widget> widgets = [];

    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isOdd) {
        widgets.add(MutableDivider(
          color: MutableColor.neutral7,
        ));
      } else {
        widgets.add(items[i ~/ 2]);
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MutableText(
          header.toUpperCase(),
          color: MutableColor.neutral2,
          weight: TypeWeight.heavy,
          size: 14,
        ),
        SizedBox(height: 9),
        MutableDivider(
          color: MutableColor.neutral7,
        ),
        ...generateItems(),
      ],
    );
  }
}
