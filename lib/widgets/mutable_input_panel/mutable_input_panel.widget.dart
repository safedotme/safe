import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_icon_sphere/mutable_icon_sphere.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableInputPanel extends StatelessWidget {
  final Widget body;
  final void Function()? onTap;
  final String title;
  final MutableIcons icon;
  final String description;

  MutableInputPanel({
    required this.body,
    this.onTap,
    required this.icon,
    this.title = "Title",
    this.description = "Description",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        kSideScreenMargin,
        6,
        kSideScreenMargin,
        kBottomScreenMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: MutableHandle()),
          SizedBox(height: 38),
          Center(
            child: MutableIconSphere(icon),
          ),
          SizedBox(height: 32),
          MutableText(
            title,
            style: TypeStyle.h3,
            align: TextAlign.center,
          ),
          SizedBox(height: 10),
          MutableText(
            description,
            style: TypeStyle.h5,
            color: MutableColor.neutral2,
            align: TextAlign.center,
          ),
          Spacer(),
          body,
          Spacer(),
          Container(
            height: 50,
            color: Color.fromARGB(255, 20, 20, 20),
          ),
        ],
      ),
    );
  }
}
