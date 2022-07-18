import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_play_button.widget.dart';

class IncidentCardImage extends StatelessWidget {
  final void Function() onPlayTap;
  final void Function() onMenuTap;

  IncidentCardImage({required this.onPlayTap, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: Stack(
        children: [
          SizedBox.expand(
            child: MutableCachedImage(
              "https://d279m997dpfwgl.cloudfront.net/wp/2020/06/GettyImages-1221138690.jpg",
              backgroundColor: kColorMap[kIncidentCardBgColor],
              fit: BoxFit.cover,
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          IncidentCardPlayButton(onTap: onPlayTap),
          Align(
            alignment: Alignment.topRight,
            child: MutableButton(
              onTap: onMenuTap,
              child: Container(
                padding: EdgeInsets.all(14),
                color: Colors.transparent,
                child: MutableIcon(
                  MutableIcons.menu,
                  size: Size(15, 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
