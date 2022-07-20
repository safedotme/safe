import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident_log/local_widgets/incident_navigation_button.widget.dart';

class NavigationButtons extends StatefulWidget {
  @override
  State<NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        children: [
          IncidentNavigationButton(
            text: core.utils.language
                    .langMap[core.state.preferences.language]!["incident_log"]
                ["contacts_button"],
            onTap: () {
              print("open contacts popup");
            },
          ),
          SizedBox(height: 10),
          IncidentNavigationButton(
            text: core.utils.language
                    .langMap[core.state.preferences.language]!["incident_log"]
                ["settings_button"],
            onTap: () {
              print("navigate to settings");
            },
          ),
        ],
      ),
    );
  }
}
