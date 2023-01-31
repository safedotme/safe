import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class MutableIconSphere extends StatelessWidget {
  final MutableIcons icon;
  final Size? size;
  MutableIconSphere(this.icon, {this.size});

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
          size: size ?? Size(30, 30),
          color: kIconColorInGradientFill,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage("assets/images/gradient.png"),
        ),
        border: Border.all(
          width: 2,
          color: Colors.white.withOpacity(0.3),
        ),
        boxShadow: core.utils.color.applyGradientShadow(64, opacity: 0.2),
      ),
    );
  }
}
