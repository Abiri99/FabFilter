import 'dart:math';
import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CI extends StatefulWidget {
  final Function tapCallback;
  final double fabWidth;

  final Animation<double> actionIconTranslateAnimation;
  final Animation<double> fadeOutAnimation;
  final Animation<double> fabRotationAnimation;

  CI({
    Key key,
    @required this.tapCallback,
    @required this.fabWidth,
    @required this.fadeOutAnimation,
    @required this.fabRotationAnimation,
    @required this.actionIconTranslateAnimation,
  })  : assert(tapCallback != null),
        assert(fabWidth != null),
        assert(actionIconTranslateAnimation != null),
        assert(fadeOutAnimation != null),
        assert(fabRotationAnimation != null),
        super(key: key);

  @override
  CIState createState() => CIState();
}

class CIState extends State<CI> {

  animationListener() {
    setState(() {

    });
  }

  @override
  void initState() {
    widget.actionIconTranslateAnimation.addListener(animationListener);
    widget.fabRotationAnimation.addListener(animationListener);
    widget.fadeOutAnimation.addListener(animationListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.actionIconTranslateAnimation.removeListener(animationListener);
    widget.fabRotationAnimation.removeListener(animationListener);
    widget.fadeOutAnimation.removeListener(animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        -1.0 +
            (widget.actionIconTranslateAnimation.value * 0.4) +
            (0.6 * widget.fadeOutAnimation.value),
        1.0 - widget.fadeOutAnimation.value,
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
            opacity: widget.actionIconTranslateAnimation.value,
            child: Consumer<FiltersChangeNotifier>(
              builder: (context, fcn, __) => Transform.rotate(
                angle: pi * widget.fabRotationAnimation.value,
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
