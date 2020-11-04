import 'dart:math';

import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CloseIcon extends StatefulWidget {
  final Function tapCallback;
  final double fabWidth;

  CloseIcon({
    Key key,
    @required this.tapCallback,
    @required this.fabWidth,
  })  : assert(tapCallback != null),
        assert(fabWidth != null),
        super(key: key);

  @override
  CloseIconState createState() => CloseIconState();
}

class CloseIconState extends State<CloseIcon> {

  double actionIconTranslateAnimationValue;
  setActionIconTranslateAnimationValue(double value) {
    setState(() {
      this.actionIconTranslateAnimationValue = value;
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
    actionIconTranslateAnimationValue = 0.0;
    fadeOutAnimationValue = 0.0;
    fabRotationAnimationValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        -1.0 +
            (actionIconTranslateAnimationValue * 0.4) +
            (0.6 * fadeOutAnimationValue),
        1.0 - fadeOutAnimationValue,
      ),
      // bottom: 16,
      // left: _actionIconTranslateAnimation.value *
      //     (constraints.maxWidth / 5),

      // left: 16 +
      //     (_actionIconTranslateAnimation.value *
      //         constraints.maxWidth /
      //         4) -
      //     0,
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
            opacity: actionIconTranslateAnimationValue,
            child: Consumer<FiltersChangeNotifier>(
              builder: (context, fcn, __) => Transform.rotate(
                angle: pi * fabRotationAnimationValue,
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
