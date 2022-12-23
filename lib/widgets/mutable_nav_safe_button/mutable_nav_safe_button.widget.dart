import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';

class MutableNavSafeButton extends StatelessWidget {
  final void Function()? onTap;

  MutableNavSafeButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of(context, listen: false);
    return MutableButton(
      onTap: onTap,
      animateBeforeVoidCallback: true,
      child: Container(
        height: kNavButtonSize,
        width: kNavButtonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: kPrimaryGradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: core.utils.color.applyGradientShadow(kNavButtonSize),
        ),
        child: Center(
          child: Image.asset(
            "assets/images/safe_logo_button.png",
            height: 26,
          ),
        ),
      ),
    );
  }
}
