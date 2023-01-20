import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/screens/settings/local_widgets/animated_heart.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';
import 'package:safe/widgets/mutable_gradient_shimmer/mutable_gradient_shimmer.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class OurStoryBanner extends StatefulWidget {
  @override
  State<OurStoryBanner> createState() => _OurStoryBannerState();
}

class _OurStoryBannerState extends State<OurStoryBanner> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      scale: 0.95,
      onTap: () {
        launchUrl(kStoryUrl);
      },
      child: MutableGradientShimmer(
        borderRadius: 12,
        builder: (key) => MutableGradientBorder(
          borderRadius: 12,
          width: kBorderWidth,
          child: Container(
            key: key,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kColorMap[MutableColor.neutral10],
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: kPrimaryGradientColors
                    .map((e) => e.withOpacity(0.1))
                    .toList(),
                begin: Alignment(-2, -2),
                end: Alignment(2, 2),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MutableText(
                      core
                          .utils
                          .language
                          .langMap[core.state.preferences.language]!["settings"]
                              ["story"]["header"]
                          .toUpperCase(),
                      weight: TypeWeight.bold,
                      size: 14,
                    ),
                    MutableIcon(
                      MutableIcons.caretRight,
                      color: kColorMap[MutableColor.neutral2]!,
                      size: Size(6.5, 12),
                    ),
                  ],
                ),
                SizedBox(height: 17),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: kPrimaryGradientColors
                              .map((e) => e.withOpacity(0.15))
                              .toList(),
                          begin: Alignment(-2, -2),
                          end: Alignment(2, 2),
                        ),
                      ),
                      child: Center(
                        child: AnimatedHeart(),
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: MutableText(
                        core.utils.language.langMap[core.state.preferences
                            .language]!["settings"]["story"]["body"],
                        size: 14,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
