import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_overlay_button/mutable_overlay_button.widget.dart';

class IncidentHeaderBox extends StatefulWidget {
  @override
  State<IncidentHeaderBox> createState() => _IncidentHeaderBoxState();
}

class _IncidentHeaderBoxState extends State<IncidentHeaderBox> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return SizedBox(
      height: query.size.height * 0.6,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Container(
              color: kColorMap[MutableColor.neutral7],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: SizedBox(
              width: query.size.width,
              child: MutableCachedImage(
                "https://i.ibb.co/hBNBMK1/Rectangle-1083.png", // Replace with thumbnail
                shimmerColor: kShimmerAnimationColor,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kColorMap[MutableColor.neutral10]!,
                  kColorMap[MutableColor.neutral10]!.withOpacity(0)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kColorMap[MutableColor.neutral10]!.withOpacity(0.5),
                  kColorMap[MutableColor.neutral10]!.withOpacity(0),
                  kColorMap[MutableColor.neutral10]!.withOpacity(0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                kSideScreenMargin,
                query.padding.top,
                kSideScreenMargin,
                0,
              ),
              child: Row(
                children: [
                  MutableOverlayButton(
                    animateBeforeVoidCallback: true,
                    icon: MutableIcon(
                      MutableIcons.cancel,
                      size: Size(12, 12),
                    ),
                    onTap: () {
                      core.state.incident.controller.close();
                    },
                  ),
                  Spacer(),
                  MutableOverlayButton(
                    padding: EdgeInsets.only(bottom: 3),
                    icon: MutableIcon(
                      MutableIcons.share,
                      size: Size(21, 18),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(width: 15),
                  MutableOverlayButton(
                    padding: EdgeInsets.only(top: 1.5),
                    icon: MutableIcon(
                      MutableIcons.menu,
                      size: Size(14, 24),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
