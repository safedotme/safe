import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_body_loader.widget.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentCardBody extends StatefulWidget {
  final String name;
  final String address;
  final bool isLoading;

  IncidentCardBody({
    required this.name,
    required this.address,
    required this.isLoading,
  });

  @override
  State<IncidentCardBody> createState() => _IncidentCardBodyState();
}

class _IncidentCardBodyState extends State<IncidentCardBody> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Generates placeholder boxes while items load
                widget.isLoading
                    ? IncidentBodyLoader(150)
                    : MutableText(
                        widget.name,
                        style: TypeStyle.h5,
                        weight: TypeWeight.bold,
                      ),

                SizedBox(
                  height: widget.isLoading ? 8 : kIncidentBodyVerticalSpacing,
                ),

                // Generates placeholder boxes while items load
                ...List.generate(
                  3,
                  (i) => widget.isLoading
                      ? i.isEven
                          ? IncidentBodyLoader(200 - (i * 10), height: 14)
                          : SizedBox(height: 4)
                      : SizedBox(),
                ).toList(),

                // Generates placeholder boxes while items load
                widget.isLoading
                    ? SizedBox()
                    : MutableText(
                        widget.address,
                        style: TypeStyle.body,
                        color: MutableColor.neutral2,
                      ),
                SizedBox(height: kIncidentBodyVerticalSpacing),

                // Will not display if not loading
                widget.isLoading
                    ? SizedBox()
                    : Row(
                        children: [
                          MutableEmergencyContactAvatar("Kelly Wakasa"),
                          SizedBox(width: kEmergencyContactAvatarSpacing),
                          MutableEmergencyContactAvatar("Filippo Fonseca"),
                          SizedBox(width: kEmergencyContactAvatarSpacing),
                          MutableEmergencyContactAvatar("Mark Music"),
                          SizedBox(width: kEmergencyContactAvatarSpacing),
                          MutableEmergencyContactAvatar("Ashley Alexander"),
                          SizedBox(width: kEmergencyContactAvatarSpacing),
                        ],
                      ),
              ],
            ),
          ),
          SizedBox(width: 10),
          widget.isLoading
              ? IncidentBodyLoader(80, height: 22)
              : MutablePill(
                  text: core.utils.language.langMap[core
                      .state.preferences.language]!["incident_card"]["secured"],
                  icon: MutableIcons.safe,
                )
        ],
      ),
    );
  }
}
