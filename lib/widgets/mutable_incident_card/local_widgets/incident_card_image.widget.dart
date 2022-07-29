import 'package:flutter/material.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_play_button.widget.dart';

class IncidentCardImage extends StatefulWidget {
  final Incident incident;
  final void Function() onPlayTap;
  final void Function() onMenuTap;

  IncidentCardImage(
    this.incident, {
    required this.onPlayTap,
    required this.onMenuTap,
  });

  @override
  State<IncidentCardImage> createState() => _IncidentCardImageState();
}

class _IncidentCardImageState extends State<IncidentCardImage>
    with TickerProviderStateMixin {
  late Animation animation;

  @override
  void initState() {
    animate();
    super.initState();
  }

  void animate() async {
    var controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: kCachedImageLoadDuration),
    );

    animation = Tween<double>(begin: 0, end: 0.6).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.addListener(() {
      setState(() {});
    });

    await Future.delayed(Duration(milliseconds: kCachedImageLoadDuration));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kIncidentCardImageHeight,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            color: kColorMap[kIncidentCardLoaderColor],
            child: widget.incident.thumbnail != null
                ? MutableCachedImage(
                    widget.incident.thumbnail!,
                    backgroundColor: kColorMap[kIncidentCardLoaderColor]!,
                    fit: BoxFit.cover,
                    shimmerColor: kBoxLoaderShimmerColor,
                  )
                : Container(
                    color: kColorMap[kIncidentCardLoaderColor]!,
                  ),
          ),

          // Gradient Overlay

          widget.incident.thumbnail != null
              ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(animation.value),
                        Colors.transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                )
              : SizedBox(),

          IncidentCardPlayButton(onTap: widget.onPlayTap),

          Align(
            alignment: Alignment.topRight,
            child: MutableButton(
              onTap: widget.onMenuTap,
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
