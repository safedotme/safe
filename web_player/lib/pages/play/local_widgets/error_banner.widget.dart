import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ErrorBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 80),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kErrorBannerBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: MutableShimmer(
            animateToColor:
                kColorMap[MutableColor.secondaryRed]!.withOpacity(0.2),
            child: Container(
              width: 295,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xff261D1C),
                borderRadius: BorderRadius.circular(kErrorBannerBorderRadius),
                border: Border.all(
                  width: kBorderWidth,
                  color:
                      kColorMap[MutableColor.secondaryRed]!.withOpacity(0.15),
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
                        "assets/images/error.png",
                        height: 14,
                      ),
                      SizedBox(width: 2),
                      MutableText(
                        "Video Stream won't load on an iPhone",
                        size: 14,
                        weight: TypeWeight.semiBold,
                        align: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(height: 3),
                  MutableText(
                    "Open the link on a desktop or laptop computer for full functionality",
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
    );
  }
}
