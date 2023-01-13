import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident/local_widgets/data_point_wrapper.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';

class IncidentDownloadBox extends StatefulWidget {
  @override
  State<IncidentDownloadBox> createState() => _IncidentDownloadBoxState();
}

class _IncidentDownloadBoxState extends State<IncidentDownloadBox> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: () {
        // TODO: Donwload zip
        print("download ZIP");
      },
      child: DataPointWrapper(
        child: Padding(
          padding: EdgeInsets.all(kIncidentDataBoxPadding),
          child: Row(
            children: [
              Image.asset(
                "assets/images/download.png",
                height: 55,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/download_text.png", height: 37),
                  SizedBox(height: 6),
                  MutablePill(
                    isButton: true,
                    letterSpacing: LetterSpacingType.numeric,
                    text: core
                        .utils
                        .language
                        .langMap[core.state.preferences.language]!["incident"]
                            ["recorded_data"]["download"]
                        .toUpperCase(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
