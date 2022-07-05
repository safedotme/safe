import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableIconSphere extends StatelessWidget {
  final IconData icon;
  MutableIconSphere(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      // ignore: sort_child_properties_last
      child: Center(
        child: Icon(
          icon,
          size: 30,
          color: kColorMap[MutableColor.neutral1]!.withOpacity(0.7),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: kPrimaryGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          // Color Shadows
          ...List.generate(
            3,
            (i) => BoxShadow(
              color: kPrimaryGradientColors[2 * i].withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(
                (i.isEven ? -1 : 1) * 4,
                4 * (i > 1 ? -1 : 1),
              ),
            ),
          ),
          BoxShadow(
            offset: Offset(2, -2),
            color: Colors.black.withOpacity(0.6),
            blurRadius: 20,
            inset: true,
          ),
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 20,
            color: Colors.white.withOpacity(0.4),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(0, 2),
            color: Colors.white.withOpacity(0.7),
            blurRadius: 1,
            inset: true,
          ),
        ],
      ),
    );
  }
}
