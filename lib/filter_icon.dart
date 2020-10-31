import 'package:flutter/material.dart';

import 'line.dart';

class FilterIcon extends StatelessWidget {

  final Color color;

  FilterIcon({this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Line(
          height: 3,
          width: 24,
          color: color ?? Colors.white38,
          // color: color ?? Color(0xff8EB8C6),
        ),
        SizedBox(height: 4,),
        Line(
          height: 3,
          width: 16,
          color: color ?? Colors.white38,
        ),
        SizedBox(height: 4,),
        Line(
          height: 3,
          width: 10,
          color: color ?? Colors.white38,
        ),
      ],
    );
  }
}
