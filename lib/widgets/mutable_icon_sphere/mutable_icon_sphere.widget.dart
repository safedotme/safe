import 'package:flutter/widgets.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableIconSphere extends StatelessWidget {
  const MutableIconSphere({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
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

          BoxShadow()
        ],
      ),
    );
  }
}
