import 'package:flutter/material.dart';
import 'package:flutter_sqlite/constants/constants.dart';

class IconContent extends StatelessWidget {
  final IconData icon;
  final String label;

  IconContent({this.icon, this.label});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        icon,
        size: 40,
        color: Colors.white,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        label,
        style: kLableTextStyle,
      ),
    ]);
  }
}
