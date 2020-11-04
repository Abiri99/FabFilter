import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_icon.dart';

class FilterIconContainer extends StatefulWidget {
  final double fabWidth;
  final BoxConstraints constraints;
  // final AnimationStatus controllerStatus;
  final Function filterControllerCallback;

  FilterIconContainer({
    Key key,
    @required this.fabWidth,
    @required this.constraints,
    // @required this.controllerStatus,
    @required this.filterControllerCallback,
  })  : assert(fabWidth != null),
        assert(constraints != null),
        // assert(controllerStatus != null),
        assert(filterControllerCallback != null),
        super(key: key);

  @override
  FilterIconContainerState createState() => FilterIconContainerState();
}

class FilterIconContainerState extends State<FilterIconContainer> {
  double xAxisPositionAnimationValue;

  setXAxisPositionAnimationValue(double value) {
    setState(() {
      this.xAxisPositionAnimationValue = value;
    });
  }

  double yAxisPositionAnimationValue;

  setYAxisPositionAnimationValue(double value) {
    setState(() {
      this.yAxisPositionAnimationValue = value;
    });
  }

  double fadeOutAnimationValue;

  setFadeOutAnimationValue(double value) {
    setState(() {
      this.fadeOutAnimationValue = value;
    });
  }

  double fabRevealAnimationValue;

  setFabRevealAnimationValue(double value) {
    setState(() {
      fabRevealAnimationValue = value;
    });
  }

  double actionIconsTranslateAnimationValue;

  setActionIconsTranslateAnimationValue(double value) {
    setState(() {
      this.actionIconsTranslateAnimationValue = value;
    });
  }

  bool controllerCompleted;
  setControllerCompleted(bool value) {
    setState(() {
      this.controllerCompleted = value;
    });
  }

  @override
  void initState() {
    actionIconsTranslateAnimationValue = 0.0;
    fabRevealAnimationValue = 0.0;
    fadeOutAnimationValue = 0.0;
    yAxisPositionAnimationValue = 0.0;
    xAxisPositionAnimationValue = 0.0;
    controllerCompleted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        (1 - xAxisPositionAnimationValue) +
            (actionIconsTranslateAnimationValue * 0.6) -
            (fadeOutAnimationValue * 0.6),
        (1 - yAxisPositionAnimationValue) +
            (fabRevealAnimationValue) -
            (fadeOutAnimationValue),
      ),
      // alignment: _xAxisPositionAnimation.status == AnimationStatus.forward ? Alignment(
      //   (1 - _xAxisPositionAnimation.value),
      //   (1 - _yAxisPositionAnimation.value),
      // ) : _fabRevealAnimation.status == AnimationStatus.forward ? Alignment(
      //   0,
      //   _fabRevealAnimation.value,
      // ) : Alignment(
      //   _actionIconTranslateAnimation.value,
      //   1.0,
      // ),
      child: Opacity(
        opacity: 1 - fadeOutAnimationValue,
        child: IgnorePointer(
          ignoring: !controllerCompleted,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // behavior: _controller.status == AnimationStatus.completed ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
            onTap: () {
              if (controllerCompleted)
                widget.filterControllerCallback();
            },
            child: Container(
              height: widget.fabWidth,
              width: widget.fabWidth,
              margin: EdgeInsets.all(36.0 * (1 - fabRevealAnimationValue)),
              child: Consumer<FiltersChangeNotifier>(
                builder: (context, fcn, __) => FilterIcon(
                  color: fcn.mainStatus == FilterStatus.Changed
                      ? Colors.white
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
