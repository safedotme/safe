import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableAvatar extends StatelessWidget {
  final User? user;
  final void Function()? onTap;

  MutableAvatar(
    this.user, {
    this.onTap,
  });

  Widget handleResponse({
    required Widget pfp,
    required Widget initials,
    required Widget loader,
  }) {
    if (user == null) {
      return loader;
    }

    if (user!.picturePath != null) {
      return pfp;
    }

    return initials;
  }

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return MutableButton(
      onTap: onTap,
      child: MutableGradientBorder(
        width: kBorderWidth,
        borderRadius: kNavButtonSize / 2,
        child: Container(
          height: kNavButtonSize,
          width: kNavButtonSize,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: kPrimaryGradientColors
                  .map((e) => e.withOpacity(0.2))
                  .toList(),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: handleResponse(
            pfp: ClipRRect(
              borderRadius: BorderRadius.circular(kNavButtonSize / 2),
              child: CachedNetworkImage(imageUrl: user!.picturePath ?? ""),
            ),
            initials: Center(
              child: ShaderMask(
                shaderCallback: (rect) => LinearGradient(
                  colors: kPrimaryGradientColors,
                  begin: Alignment(-1.7, 0),
                  end: Alignment(1.7, 0),
                ).createShader(rect),
                child: MutableText(
                  core.utils.name.genInitials(user!.name),
                  style: TypeStyle.h5,
                  weight: TypeWeight.black,
                ),
              ),
            ),
            loader: CircularProgressIndicator(
              strokeWidth: kBorderWidth,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
