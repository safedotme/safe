import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableHomeBanner extends StatefulWidget {
  final double height;
  final PanelController? controller;
  final PanelState state;
  final void Function()? onTap;
  final void Function()? onClose;
  final Widget child;
  final MutableColor backgroundColor;
  final MutableColor borderColor;

  MutableHomeBanner({
    this.height = 124,
    this.controller,
    this.child = const SizedBox(),
    this.onClose,
    this.state = PanelState.OPEN,
    this.onTap,
    this.backgroundColor = MutableColor.neutral8,
    this.borderColor = MutableColor.neutral8,
  });

  @override
  State<MutableHomeBanner> createState() => _MutableHomeBannerState();
}

class _MutableHomeBannerState extends State<MutableHomeBanner> {
  double scale = 1;
  double opacity = 1;
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return SizedBox(
      height: widget.height +
          kHomeBannerIncidentPopupMargin +
          (queryData.size.height * kIncidentLogMinPopupHeight),
      child: MutablePopup(
        onClosed: widget.onClose,
        onSlide: (pos) {
          setState(() {
            scale = core.utils.animation.percentBetweenPoints(
              lowerBound: 0,
              upperBound: 3,
              state: 2 + pos,
            );

            opacity = core.utils.animation.percentBetweenPoints(
              lowerBound: 0.5,
              upperBound: 1,
              state: pos,
            );
          });
        },
        controller: widget.controller,
        backdropTapClose: false,
        defaultState: widget.state,
        enableBorder: false,
        maxHeight: widget.height +
            kHomeBannerIncidentPopupMargin +
            (queryData.size.height * kIncidentLogMinPopupHeight),
        minHeight: kHomeBannerIncidentPopupMargin,
        style: MutablePopupStyle(
          backdropEnabled: false,
          backgroundColor: Colors.transparent,
          borderRadius: BorderRadius.zero,
          borderColor: Colors.transparent,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: MutableButton(
                onTap: widget.onTap,
                child: Container(
                  height: widget.height,
                  margin: EdgeInsets.symmetric(horizontal: kSideScreenMargin),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(kHomeBannerBorderRadius),
                    border: Border.all(
                      width: kBorderWidth,
                      color: kColorMap[widget.borderColor]!,
                    ),
                    color: kColorMap[widget.backgroundColor]!.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MutableText(
                            "LAST INCIDENT".toUpperCase(),
                            weight: TypeWeight.bold,
                            size: 14,
                          ),
                          MutableIcon(
                            MutableIcons.caretRight,
                            size: Size(8, 12),
                          ),
                        ],
                      ),
                      Expanded(
                        child: widget.child,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
