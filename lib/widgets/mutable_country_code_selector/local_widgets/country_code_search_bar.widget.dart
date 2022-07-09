import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class CountryCodeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kSideScreenMargin,
      ),
      height: 35,
      width: double.infinity,
      color: Colors.blue.withOpacity(0.8),
    );
  }
}
