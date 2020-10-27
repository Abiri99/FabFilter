import 'package:fab_filter/change_notifier/filter2_change_notifier.dart';
import 'package:fab_filter/slider/custom_range_slider.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class FilterView2 extends StatelessWidget {
  final Filter2ChangeNotifier fcn;

  FilterView2({
    Key key,
    @required this.fcn,
  })  : assert(fcn != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 36,
        ),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                Line(
                  color: Color(0xff297295),
                  secondaryColor: Theme.of(context).primaryColor,
                  height: 16,
                  width: 120,
                  selectable: true,
                  onTap: () {
                    fcn.selectItem(0);
                  },
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
                initialFirstThumbX: fcn.slider1Values["start"] != null ? fcn.slider1Values["start"] / 100 * constraints.maxWidth : null,
                initialSecondThumbX: fcn.slider1Values["end"] != null ? fcn.slider1Values["end"] / 100 * constraints.maxWidth : null,
                onRangeChanged: (startThumbX, endThumbX) {
                  fcn.setSlider1Values(startThumbX/constraints.maxWidth * 100, endThumbX/constraints.maxWidth * 100);
                  // if (v1 == 24 && v2 == constraints.maxWidth - 24)
                  //   fcn.s
                },
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Line(
                  color: Color(0xff297295),
                  secondaryColor: Theme.of(context).primaryColor,
                  height: 16,
                  width: 120,
                  selectable: true,
                  onTap: () {
                    fcn.selectItem(1);
                  },
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
                initialFirstThumbX: fcn.slider2Values["start"] != null ? fcn.slider2Values["start"] / 100 * constraints.maxWidth : null,
                initialSecondThumbX: fcn.slider2Values["end"] != null ? fcn.slider2Values["end"] / 100 * constraints.maxWidth : null,
                onRangeChanged: (startThumbX, endThumbX) {
                  fcn.setSlider1Values(startThumbX/constraints.maxWidth * 100, endThumbX/constraints.maxWidth * 100);
                  // if (v1 == 24 && v2 == constraints.maxWidth - 24)
                  //   fcn.s
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
