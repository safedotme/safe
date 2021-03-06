import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class AuthButton extends StatefulWidget {
  final AuthType type;

  AuthButton(this.type);

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  Widget displayBorder(Widget body) => widget.type == AuthType.signup
      ? MutableGradientBorder(
          borderRadius: 30,
          width: 3,
          begin: Alignment(-1.5, 1.5),
          end: Alignment(1, -2.5),
          child: body,
        )
      : body;

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: () {
        if (widget.type == AuthType.signup) {
          core.state.auth.setAuthType(widget.type);
          core.state.auth.nameInputController.open();
          return;
        }
        core.state.auth.setAuthType(widget.type);

        // Checks if should open permission popup
        bool hasPermissions = core.services.permissions.checkPermissions(
          core,
          sendError: false,
        );

        if (!hasPermissions) {
          core.state.auth.permissionsController.open();
          return;
        }

        core.state.auth.phoneVerificationController.open();
      },
      child: displayBorder(
        Container(
          height: 60,
          width: 228,
          decoration: BoxDecoration(
            gradient: widget.type == AuthType.signup
                ? LinearGradient(
                    colors: kPrimaryGradientColors
                        .map((e) =>
                            e.withOpacity(kTransparencyMap[Transparency.v20]!))
                        .toList(),
                    begin: Alignment(-1.5, 1.5),
                    end: Alignment(1, -2.5),
                  )
                : null,
            borderRadius: BorderRadius.circular(30),
            color: widget.type == AuthType.login
                ? core.utils.color.translucify(
                    MutableColor.neutral4,
                    Transparency.v16,
                  )
                : null,
          ),
          child: Center(
            child: Observer(
              builder: (_) => MutableText(
                widget.type == AuthType.signup
                    ? core.utils.language.langMap[
                            core.state.preferences.language]!["welcome"]
                        ["signupButton"] // "Create an account"
                    : core.utils.language.langMap[
                            core.state.preferences.language]!["welcome"]
                        ["loginButton"], // "I already have one"
                style: TypeStyle.h3,
                weight: TypeWeight.bold,
                color: widget.type == AuthType.login
                    ? MutableColor.neutral2
                    : MutableColor.neutral1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
