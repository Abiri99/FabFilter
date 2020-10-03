import 'package:flutter/material.dart';

import 'line.dart';

class FilterIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Line(
          height: 3,
          width: 24,
          color: Color(0xff8EB8C6),
        ),
        SizedBox(height: 4,),
        Line(
          height: 3,
          width: 18,
          color: Color(0xff8EB8C6),
        ),
        SizedBox(height: 4,),
        Line(
          height: 3,
          width: 12,
          color: Color(0xff8EB8C6),
        ),
      ],
    );
  }
}
