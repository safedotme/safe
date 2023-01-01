import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ControlButton extends StatefulWidget {
  final void Function() onTap;
  final MutableIcons icon;
  final String text;
  final ControlButtonController? controller;
  final Size iconSize;

  ControlButton({
    required this.icon,
    required this.onTap,
    required this.text,
    this.controller,
    this.iconSize = const Size(10, 10),
  });

  @override
  State<ControlButton> createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  bool active = false;

  void setActive(bool v) {
    setState(() {
      active = v;
    });
  }

  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller!.setState(this);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MutableButton(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kColorMap[MutableColor.neutral8],
                border: Border.all(
                  width: kBorderWidth,
                  color: kColorMap[MutableColor.neutral7]!,
                ),
                borderRadius:
                    BorderRadius.circular(kCaptureControlBorderRadius),
              ),
              child: Row(
                children: [
                  MutableIcon(widget.icon, size: widget.iconSize),
                  SizedBox(width: 8),
                  MutableText(widget.text),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: active ? 1 : 0,
              duration: Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(kCaptureControlBorderRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ControlButtonController {
  _ControlButtonState? _state;

  // ignore: library_private_types_in_public_api
  void setState(_ControlButtonState s) => _state = s;

  bool get isAttached => _state != null;

  void setActive(bool active) {
    assert(_state != null, "Controller has not been attached");
    _state!.setActive(active);
  }
}
