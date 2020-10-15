import 'package:fab_filter/slider/custom_range_slider.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class FilterView2 extends StatelessWidget {

  FilterView2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 36,),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
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
            SizedBox(height: 8,),
            LayoutBuilder(
              builder: (context, constraints) => CustomRangeSlider(
                width: constraints.maxWidth,
              ),
            ),
            SizedBox(height: 24,),
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
              height: 8,
            ),
            LayoutBuilder(
              builder: (context, constraints) => CustomRangeSlider(
                width: constraints.maxWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
