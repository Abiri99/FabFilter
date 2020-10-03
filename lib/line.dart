import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  Line({
    this.color,
    this.width = double.infinity,
    this.height = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  }
}
