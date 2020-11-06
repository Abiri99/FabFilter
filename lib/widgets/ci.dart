import 'dart:math';
import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CI extends StatefulWidget {
  final AnimationController animationController;
  final AnimationController filterAnimationController;

  final Function tapCallback;
  final double fabWidth;

  CI({
    Key key,
    @required this.tapCallback,
    @required this.fabWidth,
    @required this.animationController,
    @required this.filterAnimationController,
  })  : assert(tapCallback != null),
        assert(fabWidth != null),
        assert(animationController != null),
        assert(filterAnimationController != null),
        super(key: key);

  @override
  CIState createState() => CIState();
}

class CIState extends State<CI> {

  Animation<double> actionIconTranslationAnimation;
  Animation<double> fadeOutAnimation;
  Animation<double> fabRotationAnimation;

  @override
  void initState() {
    actionIconTranslationAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.5,
        0.7,
        curve: Curves.easeOut,
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
    fabRotationAnimation = CurvedAnimation(
      parent: widget.filterAnimationController,
      curve: Interval(
        0.25,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        -1.0 +
            (actionIconTranslationAnimation.value * 0.4) +
            (0.6 * fadeOutAnimation.value),
        1.0 - fadeOutAnimation.value,
      ),
      child: GestureDetector(
        onTap: () {
          widget.tapCallback();
          // _controller.reverse();
        },
        child: Container(
          height: widget.fabWidth,
          width: widget.fabWidth,
          // padding: const EdgeInsets.only(top: 4.0,),
          // margin: const EdgeInsets.all(24),
          child: Opacity(
            opacity: actionIconTranslationAnimation.value,
            child: Consumer<FiltersChangeNotifier>(
              builder: (context, fcn, __) => Transform.rotate(
                angle: pi * fabRotationAnimation.value,
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: fcn.mainStatus == FilterStatus.Changed
                      ? Colors.white
                      : Color(0xff8EB8C6),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
