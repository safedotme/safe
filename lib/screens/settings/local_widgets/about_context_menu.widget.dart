import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_context_menu/local_widgets/context_menu_item.widget.dart';
import 'package:safe/widgets/mutable_context_menu/mutable_context_menu.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutContextMenu extends StatefulWidget {
  @override
  State<AboutContextMenu> createState() => _AboutContextMenuState();
}

class _AboutContextMenuState extends State<AboutContextMenu> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Positioned(
        top: core.state.preferences.contextMenuPos - 134,
        right: kSideScreenMargin - 3,
        child: MutableContextMenu(
          controller: core.state.preferences.aboutContextMenuController,
          items: [
            ContextMenuItem(
              onTap: () {
                launchUrl(kTermsOfService);
                core.state.preferences.aboutContextMenuController.close();
              },
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["support"]["about"]["terms"],
              icon: MutableIcon(
                MutableIcons.doc,
                color: Colors.white,
                size: Size(18, 19),
              ),
            ),
            ContextMenuItem(
              onTap: () {
                launchUrl(kPrivacyPolicy);
                core.state.preferences.aboutContextMenuController.close();
              },
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["support"]["about"]["privacy"],
              icon: MutableIcon(
                MutableIcons.lockCloud,
                color: Colors.white,
                size: Size(23, 16),
              ),
            ),
            ContextMenuItem(
              onTap: () {
                launchUrl(kCollaborators);
                core.state.preferences.aboutContextMenuController.close();
              },
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["support"]["about"]["collaborators"],
              icon: MutableIcon(
                MutableIcons.heart,
                color: Colors.white,
                size: Size(17, 16),
              ),
            ),
            ContextMenuItem(
              onTap: () {
                launchUrl(kMediaKit);
                core.state.preferences.aboutContextMenuController.close();
              },
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["support"]["about"]["media_kit"],
              icon: MutableIcon(
                MutableIcons.hammer,
                color: Colors.white,
                size: Size(22, 21),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
