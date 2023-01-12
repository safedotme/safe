import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutableTag extends StatelessWidget {
  final String text;
  final bool disabled;

  MutableTag({required this.text, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return MutableGradientBorder(
      width: 1,
      borderRadius: 30,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors:
                kPrimaryGradientColors.map((c) => c.withOpacity(0.1)).toList(),
            begin: Alignment(-1.5, -1.5),
            end: Alignment(1.5, 1.5),
          ),
        ),
        child: Center(
          child: ShaderMask(
            shaderCallback: (bounds) {
              var gradient = LinearGradient(
                colors: kPrimaryGradientColors,
                begin: Alignment(-2, -2),
                end: Alignment(2, 2),
              );

              return gradient.createShader(Offset.zero & bounds.size);
            },
            child: MutableText(
              text,
              weight: TypeWeight.regular,
            ),
          ),
        ),
      ),
    );
  }
}
