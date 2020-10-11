import 'package:fab_filter/custom_seekbar.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class FilterView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 36,),
        child: ListView(
          children: [
            Row(
              children: [
                Line(
                  color: Color(0xff297295),
                  height: 16,
                  width: 120,
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            LayoutBuilder(
              builder: (context, constraints) => CustomSeekBar(
                width: constraints.maxWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
