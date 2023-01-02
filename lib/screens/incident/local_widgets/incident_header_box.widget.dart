import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident/local_widgets/incident_header.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_context_menu/local_widgets/context_menu_item.widget.dart';
import 'package:safe/widgets/mutable_context_menu/mutable_context_menu.widget.dart';
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 125,
            right: 8,
            child: MutableContextMenu(
              controller: core.state.incident.menuController,
              items: [
                ContextMenuItem(
                  text: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["play_button"]["timeline"],
                  icon: MutableIcon(
                    MutableIcons.film,
                    size: Size(20.8, 16.4),
                  ),
                  onTap: () {},
                ),
                ContextMenuItem(
                  text: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["play_button"]["video"],
                  icon: MutableIcon(
                    MutableIcons.camera,
                    size: Size(22, 18),
                  ),
                  onTap: () {},
                ),
                ContextMenuItem(
                  text: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["play_button"]["map_view"],
                  icon: MutableIcon(
                    MutableIcons.map,
                    size: Size(20, 18),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: IncidentHeader(),
          ),
        ],
      ),
    );
  }
}
