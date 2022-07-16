import 'package:flutter/material.dart';
import 'package:safe/screens/incident_log/local_widgets/incident_navigation_button.widget.dart';

class NavigationButtons extends StatefulWidget {
  @override
  State<NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IncidentNavigationButton(
          text: "Contacts",
          onTap: () {
            print("contacts");
          },
        ),
        SizedBox(height: 10),
        IncidentNavigationButton(
          text: "Settings",
          onTap: () {
            print("settings");
          },
        ),
      ],
    );
  }
}
