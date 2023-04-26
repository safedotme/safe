import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:share_plus/share_plus.dart';

class ErrorBanner extends StatefulWidget {
  @override
  State<ErrorBanner> createState() => _ErrorBannerState();
}

class _ErrorBannerState extends State<ErrorBanner> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 80),
      child: MutableButton(
        scale: 0.95,
        onTap: () {
          Share.share(
            'https://live.joinsafe.me/${core.state.play.incident?.id ?? ""}',
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kErrorBannerBorderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: MutableShimmer(
              animateToColor:
                  kColorMap[MutableColor.neutral1]!.withOpacity(0.2),
              child: Container(
                width: 320,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xff202020),
                  borderRadius: BorderRadius.circular(kErrorBannerBorderRadius),
                  border: Border.all(
                    width: kBorderWidth,
                    color: Color(0xff989898).withOpacity(0.15),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/flash.png",
                          height: 14,
                        ),
                        SizedBox(width: 2),
                        MutableText(
                          "Watch a video livestream of the incident",
                          size: 14,
                          weight: TypeWeight.semiBold,
                          align: TextAlign.center,
                        )
                      ],
                    ),
                    SizedBox(height: 3),
                    MutableText(
                      "Open the link on a computer/laptop to watch livestream. Tap here to share.",
                      size: 13,
                      weight: TypeWeight.regular,
                      color: MutableColor.neutral2,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
