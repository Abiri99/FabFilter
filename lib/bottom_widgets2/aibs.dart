import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_icon.dart';

class AIBS extends StatefulWidget {
  final double fabWidth;
  final BoxConstraints constraints;
  // final Function filterControllerCallback;
  final Animation<double> filterSheetAnimation;
  final Animation<double> xAxisPositionAnimation;
  final Animation<double> yAxisPositionAnimation;
  final Animation<double> fadeOutAnimation;
  final Animation<double> fabRotateAnimation;
  // final Animation<double> actionIconsTranslateAnimation;

  AIBS({
    Key key,
    @required this.fabWidth,
    @required this.constraints,
    // @required this.filterControllerCallback,
    @required this.filterSheetAnimation,
    @required this.xAxisPositionAnimation,
    @required this.yAxisPositionAnimation,
    @required this.fadeOutAnimation,
    @required this.fabRotateAnimation,
  })
      : assert(fabWidth != null),
        assert(constraints != null),
        // assert(filterControllerCallback != null),
        assert(filterSheetAnimation != null),
        assert(xAxisPositionAnimation != null),
        assert(yAxisPositionAnimation != null),
        assert(fadeOutAnimation != null),
        assert(fabRotateAnimation != null),
        super(key: key);

  @override
  AIBSState createState() => AIBSState();
}

class AIBSState extends State<AIBS> {
  bool controllerCompleted;

  setControllerCompleted(bool value) {
    setState(() {
      this.controllerCompleted = value;
    });
  }

  animationListener() {
    setState(() {});
  }

  @override
  void initState() {
    controllerCompleted = false;
    widget.fabRotateAnimation.addListener(animationListener);
    widget.fadeOutAnimation.addListener(animationListener);
    widget.xAxisPositionAnimation.addListener(animationListener);
    widget.yAxisPositionAnimation.addListener(animationListener);
    widget.filterSheetAnimation.addListener(animationListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.fabRotateAnimation.removeListener(animationListener);
    widget.fadeOutAnimation.removeListener(animationListener);
    widget.xAxisPositionAnimation.removeListener(animationListener);
    widget.yAxisPositionAnimation.removeListener(animationListener);
    widget.filterSheetAnimation.removeListener(animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        1,1,
        // 0 + widget.xAxisPositionAnimation.value,
        // 1 - widget.fadeOutAnimation.value + widget.yAxisPositionAnimation.value,
      ),
      // bottom: 0 + _fadeOutAnimation.value * fabIconMaxY,
      // right: 0,
      // left: 0,
      child: IgnorePointer(
        ignoring: true,
        child: Opacity(
          opacity: widget.filterSheetAnimation.value,
          child: Consumer<FiltersChangeNotifier>(
            builder: (context, fcn, _) => AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: widget.fabWidth,
              width:
              widget.constraints.maxWidth * (1 - widget.fadeOutAnimation.value) + widget.fabWidth,
              margin:
              EdgeInsets.all(widget.fabRotateAnimation.value <= 0 ? 0.0 : 36.0),
              decoration: BoxDecoration(
                color: fcn.mainStatus == FilterStatus.Changed
                    ? Theme.of(context).accentColor
                    : Color(0xff33779C),
                borderRadius: BorderRadius.all(
                    Radius.circular(100 * widget.fadeOutAnimation.value)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
