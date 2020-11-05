import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_icon.dart';

class FIC extends StatefulWidget {
  final double fabWidth;
  final BoxConstraints constraints;
  final double fpvHeight;

  // final AnimationStatus controllerStatus;
  final Function filterControllerCallback;

  final Animation<double> xAxisPositionAnimation;
  final Animation<double> yAxisPositionAnimation;
  final Animation<double> fadeOutAnimation;
  final Animation<double> fabRevealAnimation;
  final Animation<double> actionIconsTranslateAnimation;

  FIC({
    Key key,
    @required this.fabWidth,
    @required this.constraints,
    @required this.fpvHeight,
    @required this.filterControllerCallback,
    @required this.xAxisPositionAnimation,
    @required this.yAxisPositionAnimation,
    @required this.fadeOutAnimation,
    @required this.fabRevealAnimation,
    @required this.actionIconsTranslateAnimation,
  })  : assert(fabWidth != null),
        assert(fpvHeight != null),
        assert(constraints != null),
        assert(filterControllerCallback != null),
        assert(xAxisPositionAnimation != null),
        assert(yAxisPositionAnimation != null),
        assert(fadeOutAnimation != null),
        assert(fabRevealAnimation != null),
        assert(actionIconsTranslateAnimation != null),
        super(key: key);

  @override
  FICState createState() => FICState();
}

class FICState extends State<FIC> {
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
    widget.xAxisPositionAnimation.addListener(animationListener);
    widget.yAxisPositionAnimation.addListener(animationListener);
    widget.actionIconsTranslateAnimation.addListener(animationListener);
    widget.fabRevealAnimation.addListener(animationListener);
    widget.fadeOutAnimation.addListener(animationListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.xAxisPositionAnimation.removeListener(animationListener);
    widget.yAxisPositionAnimation.removeListener(animationListener);
    widget.actionIconsTranslateAnimation.removeListener(animationListener);
    widget.fabRevealAnimation.removeListener(animationListener);
    widget.fadeOutAnimation.removeListener(animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        (1 - widget.xAxisPositionAnimation.value) +
            (widget.actionIconsTranslateAnimation.value * 0.6) -
            (widget.fadeOutAnimation.value * 0.6),
        (1 -
                widget.yAxisPositionAnimation.value *
                    widget.fpvHeight /
                    (widget.constraints.maxHeight)) +
            (widget.fabRevealAnimation.value * widget.fpvHeight/widget.constraints.maxHeight) -
            (widget.fadeOutAnimation.value),
      ),
      child: Opacity(
        opacity: 1 - widget.fadeOutAnimation.value,
        child: IgnorePointer(
          ignoring: !controllerCompleted,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // behavior: _controller.status == AnimationStatus.completed ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
            onTap: () {
              if (controllerCompleted) widget.filterControllerCallback();
            },
            child: Container(
              height: widget.fabWidth,
              width: widget.fabWidth,
              margin:
                  EdgeInsets.all(36.0 * (1 - widget.fabRevealAnimation.value)),
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
