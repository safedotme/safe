import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/screens/auth/local_widgets/legal_checkmark.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalCheckpoint extends StatefulWidget {
  @override
  State<LegalCheckpoint> createState() => _LegalCheckpointState();
}

class _LegalCheckpointState extends State<LegalCheckpoint> {
  late Core core;

  @override
  void initState() {
    core = Provider.of<Core>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kColorMap[MutableColor.neutral8]!.withOpacity(0.15),
        border: Border.all(
          width: kBorderWidth,
          color: kColorMap[MutableColor.neutral8]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          MutableButton(
            scale: 0.9,
            onTap: () {
              core.state.auth.setAcceptedLegal(
                !core.state.auth.acceptedLegal,
              );
            },
            child: Observer(
              builder: (_) => LegalCheckmark(core.state.auth.acceptedLegal),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: MutableButton(
            onTap: () {
              launchUrl(kTermsOfService);
            },
            child: MutableText(
              core.utils.language
                      .langMap[core.state.preferences.language]!["auth"]
                  ["phone_verification"]["terms"],
              size: 12,
              weight: TypeWeight.medium,
              color: MutableColor.neutral2,
            ),
          )),
        ],
      ),
    );
  }
}
