import 'package:flutter/material.dart';

class MutableEmojiBox extends StatelessWidget {
  final String emoji;
  final Color color;

  MutableEmojiBox({required this.emoji, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Center(
        child: Image.asset(
          "assets/images/$emoji.png",
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
