import 'package:flutter/material.dart';
import 'package:safe/screens/incident/local_widgets/data_point_wrapper.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';

class IncidentDownloadBox extends StatelessWidget {
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
                    text: "Download".toUpperCase(), // TODO: Extract
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
