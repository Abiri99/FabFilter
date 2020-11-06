import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_icon.dart';

class FIC extends StatefulWidget {
  final AnimationController animationController;
  final AnimationController filterAnimationController;
  final double fabWidth;
  final BoxConstraints constraints;
  final double fpvHeight;
  final Function filterControllerCallback;

  FIC({
    Key key,
    @required this.animationController,
    @required this.filterAnimationController,
    @required this.fabWidth,
    @required this.constraints,
    @required this.fpvHeight,
    @required this.filterControllerCallback,
  })  : assert(fabWidth != null),
        assert(fpvHeight != null),
        assert(constraints != null),
        assert(animationController != null),
        assert(filterAnimationController != null),
        super(key: key);

  @override
  FICState createState() => FICState();
}

class FICState extends State<FIC> {
  Animation<double> xAxisPositionAnimation;
  Animation<double> yAxisPositionAnimation;
  Animation<double> actionIconsTranslationAnimation;
  Animation<double> fabRevealAnimation;
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
    xAxisPositionAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeOut,
      ),
    );
    yAxisPositionAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeOut,
      ),
    );
    actionIconsTranslationAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.5,
        0.7,
        curve: Curves.easeOut,
      ),
    );
    fabRevealAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.2,
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
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) => AnimatedBuilder(
        animation: widget.filterAnimationController,
        child: Container(
          height: widget.fabWidth,
          width: widget.fabWidth,
          margin: EdgeInsets.all(36.0 * (1 - fabRevealAnimation.value)),
          child: Consumer<FiltersChangeNotifier>(
            builder: (context, fcn, __) => FilterIcon(
              color:
                  fcn.mainStatus == FilterStatus.Changed ? Colors.white : null,
            ),
          ),
        ),
        builder: (context, child) => Align(
          alignment: Alignment(
            (1 - xAxisPositionAnimation.value) +
                (actionIconsTranslationAnimation.value * 0.6) -
                (fadeOutAnimation.value * 0.6),
            (1 -
                    yAxisPositionAnimation.value *
                        widget.fpvHeight /
                        (widget.constraints.maxHeight)) +
                (fabRevealAnimation.value *
                    widget.fpvHeight /
                    widget.constraints.maxHeight) -
                (fadeOutAnimation.value),
          ),
          child: Opacity(
            opacity: 1 - fadeOutAnimation.value,
            child: IgnorePointer(
              ignoring: !controllerCompleted,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                // behavior: _controller.status == AnimationStatus.completed ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
                onTap: () {
                  if (controllerCompleted) widget.filterControllerCallback();
                },
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}