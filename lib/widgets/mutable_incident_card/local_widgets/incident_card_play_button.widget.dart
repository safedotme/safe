import 'package:flutter/material.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class IncidentCardPlayButton extends StatelessWidget {
  final void Function() onTap;

  IncidentCardPlayButton({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Center(
      // Extract
      child: MutableButton(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
          child: MutableIcon(
            MutableIcons.playLarge,
            size: Size(20, 22),
          ),
        ),
      ),
    );
  }
}
