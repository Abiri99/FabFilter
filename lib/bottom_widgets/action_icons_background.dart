import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionIconsBackground extends StatefulWidget {
  final double fabWidth;
  final BoxConstraints constraints;

  ActionIconsBackground({
    Key key,
    @required this.fabWidth,
    @required this.constraints,
  })  : assert(fabWidth != null),
        assert(constraints != null),
        super(key: key);

  @override
  ActionIconsBackgroundState createState() => ActionIconsBackgroundState();
}

class ActionIconsBackgroundState extends State<ActionIconsBackground> {
  double filterSheetAnimationValue;

  setFilterSheetAnimationValue(double value) {
    setState(() {
      this.filterSheetAnimationValue = value;
    });
  }

  double xAxisReplaceAnimationValue;

  setXAxisReplaceAnimationValue(double value) {
    setState(() {
      this.xAxisReplaceAnimationValue = value;
    });
  }

  double yAxisReplaceAnimationValue;

  setYAxisReplaceAnimationValue(double value) {
    setState(() {
      this.yAxisReplaceAnimationValue = value;
    });
  }

  double fadeOutAnimationValue;

  setFadeOutAnimationValue(double value) {
    setState(() {
      this.fadeOutAnimationValue = value;
    });
  }

  double fabRotationAnimationValue;

  setFabRotationAnimationValue(double value) {
    setState(() {
      this.fabRotationAnimationValue = value;
    });
  }

  @override
  void initState() {
    filterSheetAnimationValue = 0.0;
    fadeOutAnimationValue = 0.0;
    fabRotationAnimationValue = 0.0;
    yAxisReplaceAnimationValue = 0.0;
    xAxisReplaceAnimationValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        0 + xAxisReplaceAnimationValue,
        1 - fadeOutAnimationValue + yAxisReplaceAnimationValue,
      ),
      // bottom: 0 + _fadeOutAnimation.value * fabIconMaxY,
      // right: 0,
      // left: 0,
      child: IgnorePointer(
        ignoring: true,
        child: Opacity(
          opacity: 1.0 * filterSheetAnimationValue,
          child: Consumer<FiltersChangeNotifier>(
            builder: (context, fcn, _) => AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: widget.fabWidth,
              width:
                  widget.constraints.maxWidth * (1 - fadeOutAnimationValue) + widget.fabWidth,
              margin:
                  EdgeInsets.all(fabRotationAnimationValue <= 0 ? 0.0 : 36.0),
              decoration: BoxDecoration(
                color: fcn.mainStatus == FilterStatus.Changed
                    ? Theme.of(context).accentColor
                    : Color(0xff33779C),
                borderRadius: BorderRadius.all(
                    Radius.circular(100 * fadeOutAnimationValue)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
