import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/screens/add_contact/local_widgets/custom_contact_tab.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/phone/codes.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uuid/uuid.dart';

class CustomCupertinoContactPopup extends StatefulWidget {
  @override
  State<CustomCupertinoContactPopup> createState() =>
      _CustomCupertinoContactPopupState();
}

class _CustomCupertinoContactPopupState
    extends State<CustomCupertinoContactPopup> {
  late Core core;
  Color color = Color(0xff1D1D1D).withOpacity(0.9);
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    // Scrolling Animation
    controller = ScrollController();
    controller.addListener(() {
      double state = core.utils.animation.percentBetweenPoints(
        lowerBound: 35,
        upperBound: 150,
        state: controller.offset,
      );
      setState(() {
        color = core.utils.color.generateColor(
          Color(0xff1D1D1D).withOpacity(0.9),
          Color(0xff282829).withOpacity(0.8),
          state,
        );
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String? formatPhone(String ph) {
    Map? country;

    for (final c in kCountryCodes) {
      if (ph.contains(c["dial_code"]!)) {
        country = c;
      }
    }

    country ??= {
      "dial_code": kDefaultCountryCode,
    };

    return "${country["dial_code"]} ${ph.replaceAll(country["dial_code"], "")}";
  }

  void handleSubmit(Map c) async {
    if (c["phone"] == null) {
      core.state.preferences.actionController.trigger(
        core.utils.language.langMap[core.state.preferences.language]!["contact"]
            ["input"]["errors"]["load"],
        MessageType.error,
      );

      return;
    }

    final phone = formatPhone(c["phone"]);

    if (phone == null) {
      core.state.preferences.actionController.trigger(
        core.utils.language.langMap[core.state.preferences.language]!["contact"]
            ["input"]["errors"]["load"],
        MessageType.error,
      );

      return;
    }

    final contact = Contact(
      id: Uuid().v1(),
      userId: core.services.auth.currentUser!.uid,
      name: c["name"] ?? "",
      phone: phone,
    );

    await core.state.contact.customContactImportController.close();
    core.state.contact.setEditable(contact);
    core.state.contact.editorContactController.setValues(
      phone: contact.phone,
      name: contact.name,
      code: contact.parsePhone()["code"],
    );
    core.state.contact.editorContactController.focus(true);
    core.state.contact.setIsAdding(true);
    core.state.contact.editorController.open();
  }

  void handleSearch(String query) {
    List<Map> raw = core.state.contact.rawContacts ?? [];

    if (query.isEmpty) {
      core.state.contact.setViewContacts(raw);
      return;
    }

    List<Map> res = [];

    for (Map c in raw) {
      if (c["name"].contains(query)) {
        res.add(c);
      }
    }

    if (res.isEmpty) return;

    core.state.contact.setViewContacts(res);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return SlidingUpPanel(
      onPanelSlide: (_) {
        if (!core.state.contact.customContactKeyboardNode.hasFocus) return;
        core.state.contact.customContactKeyboardNode.unfocus();
      },
      controller: core.state.contact.customContactImportController,
      color: CupertinoColors.darkBackgroundGray,
      maxHeight: queryData.size.height - 52,
      minHeight: 0,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      panel: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Stack(
          children: [
            Observer(
              builder: (_) => ListView.separated(
                controller: controller,
                padding: EdgeInsets.only(top: 140, bottom: 52),
                itemCount: core.state.contact.viewContacts.length,
                separatorBuilder: (c, i) => Container(
                  margin: EdgeInsets.only(left: 16),
                  color: Color(0xff38383A),
                  height: 0.5,
                ),
                itemBuilder: (c, i) => CustomContactTab(
                  name: core.state.contact.viewContacts[i]["name"],
                  phone: core.state.contact.viewContacts[i]["phone"],
                  onTap: () {
                    handleSubmit(core.state.contact.viewContacts[i]);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: 110,
                    color: color,
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 10),
                    child: Column(children: [
                      Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 9),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  core.utils.language.langMap[core.state
                                          .preferences.language]!["contact"]
                                      ["import"]["icloud"],
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontFamily: "TextSemibold",
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    core.state.contact
                                        .customContactImportController
                                        .close();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                                    child: Text(
                                      core.utils.language.langMap[core.state
                                              .preferences.language]!["contact"]
                                          ["import"]["cancel"],
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: CupertinoColors.activeBlue,
                                        decoration: TextDecoration.none,
                                        fontFamily: "TextRegular",
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: CupertinoSearchTextField(
                          focusNode:
                              core.state.contact.customContactKeyboardNode,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: "TextRegular",
                            fontWeight: FontWeight.normal,
                          ),
                          onSubmitted: handleSearch,
                          onChanged: handleSearch,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
