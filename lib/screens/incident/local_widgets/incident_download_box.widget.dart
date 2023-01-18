import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/screens/incident/local_widgets/data_point_wrapper.widget.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';
import 'package:share_plus/share_plus.dart';

class IncidentDownloadBox extends StatefulWidget {
  final Incident incident;

  IncidentDownloadBox(this.incident);
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
      onTap: () async {
        core.state.incident.overlayController.show();
        final file = await core.services.export.export(widget.incident);

        if (file == null) {
          core.state.preferences.actionController.trigger(
            "Exporting failed", // TODO: Extract
            MessageType.error,
          );

          core.services.analytics.log(
            AnalyticsLog(
              channel: "error",
              event: "exporting-failed",
              description: "Failed to export incident. File returned null.",
              icon: "🚨",
              tags: {
                "userid": widget.incident.userId,
                "incidentid": widget.incident.id,
              },
            ),
          );
          return;
        }
        core.state.incident.overlayController.hide();

        Share.shareXFiles([XFile(file.path)], subject: "Incident Data");
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
