import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';

class TutorialComponent extends StatelessWidget {
  final String image;
  final Function()? onTap;

  TutorialComponent(this.image, {this.onTap});
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return MutableButton(
      onTap: onTap,
      child: SizedBox(
        width: query.size.width - kSideScreenMargin * 2,
        child: Image.asset("assets/images/welcome/$image.png"),
      ),
    );
  }
}
