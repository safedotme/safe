import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';

class IncidentCardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: MutableCachedImage(
            "https://d279m997dpfwgl.cloudfront.net/wp/2020/06/GettyImages-1221138690.jpg",
            backgroundColor: kColorMap[kIncidentCardBgColor],
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // Play Button
        // Menu
      ],
    );
  }
}
