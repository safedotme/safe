import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class MutableIconSphere extends StatelessWidget {
  final MutableIcons icon;
  MutableIconSphere(this.icon);

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of(context, listen: false);

    return Container(
      height: 64,
      width: 64,
      // ignore: sort_child_properties_last
      child: Center(
        child: MutableIcon(
          icon,
          size: Size(30, 30),
          color: kIconColorInGradientFill,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: kPrimaryGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: core.utils.color.applyGradientShadow(64),
      ),
    );
  }
}
