import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class IncidentCardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: CachedNetworkImage(
            imageUrl:
                "https://d279m997dpfwgl.cloudfront.net/wp/2020/06/GettyImages-1221138690.jpg",
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
