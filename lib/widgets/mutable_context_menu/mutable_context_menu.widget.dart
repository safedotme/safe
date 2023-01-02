import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_context_menu/local_widgets/context_menu_item.widget.dart';

class MutableContextMenu extends StatefulWidget {
  final List<ContextMenuItem> items;
  final ContextMenuController? controller;
  final Alignment align;

  MutableContextMenu({
    this.items = const [],
    this.controller,
    this.align = Alignment.bottomRight,
  });

  @override
  State<MutableContextMenu> createState() => _MutableContextMenuState();
}

class _MutableContextMenuState extends State<MutableContextMenu>
    with TickerProviderStateMixin {
  // ⬇️ FIELDS
  late AnimationController controller;
  late Animation<double> animation;

  // ⬇️ STATE
  bool visible = false;
  double opacity = 0;
  double scale = 0;
  bool isOpen = false;

  Future<void> toggle() {
    if (isOpen) {
      return close();
    }

    return open();
  }

  Future<void> open() async {
    isOpen = true;
    await controller.forward();
  }

  Future<void> close() async {
    isOpen = false;
    await controller.reverse();
  }

  void initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    controller.addListener(() {
      setState(() {
        scale = animation.value;
        opacity = animation.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initAnimation();

    if (widget.controller != null) {
      widget.controller!.setState(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: opacity != 0,
      child: Transform.scale(
        scale: scale,
        alignment: widget.align,
        child: Opacity(
          opacity: opacity > 1 ? 1 : opacity,
          child: ClipRRect(
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
                    widget.items.length + widget.items.length - 1,
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
                        onTap: widget.items[(index / 2).round()].onTap,
                        text: widget.items[(index / 2).round()].text,
                        icon: widget.items[(index / 2).round()].icon,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContextMenuController {
  _MutableContextMenuState? _state;

  // ignore: library_private_types_in_public_api
  void setState(_MutableContextMenuState s) => _state = s;

  bool get isAttached => _state != null;

  Future<void> toggle() async {
    assert(_state != null, "Controller is not attached");

    await _state!.toggle();
  }

  Future<void> open() async {
    assert(_state != null, "Controller is not attached");

    await _state!.open();
  }

  Future<void> close() async {
    assert(_state != null, "Controller is not attached");

    await _state!.close();
  }
}
