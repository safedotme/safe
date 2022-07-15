import 'package:flutter/material.dart';

class MutableHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Color(0xff44494A),
      ),
    );
  }
}
