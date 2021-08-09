import 'dart:ui';

import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  // final Color colour;
  final cardChild;
  final Function onPress;
  final ImageProvider picture;
  ReusableCard({this.cardChild, this.onPress, this.picture});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 180,
        child: cardChild,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: picture != null
              ? DecorationImage(
                  image: picture,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                )
              : null,
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF111328),
        ),
      ),
    );
  }
}
