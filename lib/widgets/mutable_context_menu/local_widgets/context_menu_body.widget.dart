import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_context_menu/local_widgets/context_menu_item.widget.dart';

class ContextMenuBody extends StatelessWidget {
  final List<ContextMenuItem> items;

  ContextMenuBody({required this.items});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kContextMenuBorderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 80,
          sigmaY: 80,
        ),
        child: Container(
          width: kContextMenuWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kContextMenuBorderRadius),
            color: kColorMap[MutableColor.iosDarkGrey]!.withOpacity(0.5),
          ),
          child: Column(
            children: List.generate(
              items.length + items.length - 1,
              (index) {
                // Border
                if (index.isOdd) {
                  return Container(
                    height: 0.5,
                    color: Color(0xff424144),
                  );
                }

                // Items
                return ContextMenuItem(
                  onTap: items[(index / 2).round()].onTap,
                  text: items[(index / 2).round()].text,
                  icon: items[(index / 2).round()].icon,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
