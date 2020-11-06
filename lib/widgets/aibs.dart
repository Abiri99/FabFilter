import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_icon.dart';

class AIBS extends StatefulWidget {
  final double fabWidth;
  final BoxConstraints constraints;
  final AnimationController animationController;
  final AnimationController filterAnimationController;

  AIBS({
    Key key,
    @required this.fabWidth,
    @required this.constraints,
    @required this.animationController,
    @required this.filterAnimationController,
  })  : assert(fabWidth != null),
        assert(constraints != null),
        assert(animationController != null),
        assert(filterAnimationController != null),
        super(key: key);

  @override
  AIBSState createState() => AIBSState();
}

class AIBSState extends State<AIBS> {

  Animation<double> fadeInAnimation;
  Animation<double> fabRotationAnimation;
  Animation<double> fadeOutAnimation;

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
    fadeInAnimation  = CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeOut,
      ),
    );
    fabRotationAnimation = CurvedAnimation(
      parent: widget.filterAnimationController,
      curve: Interval(
        0.25,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    fadeOutAnimation = CurvedAnimation(
      parent: widget.filterAnimationController,
      curve: Interval(
        0.0,
        0.1,
        curve: Curves.easeOut,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        1, 1,
        // 0 + widget.xAxisPositionAnimation.value,
        // 1 - widget.fadeOutAnimation.value + widget.yAxisPositionAnimation.value,
      ),
      // bottom: 0 + _fadeOutAnimation.value * fabIconMaxY,
      // right: 0,
      // left: 0,
      child: IgnorePointer(
        ignoring: true,
        child: Opacity(
          opacity: fadeInAnimation.value,
          child: Consumer<FiltersChangeNotifier>(
            builder: (context, fcn, _) => AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: widget.fabWidth,
              width: widget.constraints.maxWidth *
                      (1 - fadeOutAnimation.value) +
                  widget.fabWidth,
              margin: EdgeInsets.all(
                  fabRotationAnimation.value <= 0 ? 0.0 : 36.0),
              decoration: BoxDecoration(
                color: fcn.mainStatus == FilterStatus.Changed
                    ? Theme.of(context).accentColor
                    : Color(0xff33779C),
                borderRadius: BorderRadius.all(
                    Radius.circular(100 * fadeOutAnimation.value)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
