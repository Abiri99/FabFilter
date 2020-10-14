import 'package:flutter/material.dart';

import 'filter_icon.dart';

class ActionIcons extends StatelessWidget {
  final Animation fabIconFallAnimation;
  final Animation yAxisPositionAnimation;
  final Animation xAxisPositionAnimation;
  final Animation actionIconTranslateAnimation;
  final BoxConstraints constraints;

  ActionIcons({
    this.fabIconFallAnimation,
    this.xAxisPositionAnimation,
    this.yAxisPositionAnimation,
    this.actionIconTranslateAnimation,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (1 - fabIconFallAnimation.value) *
              (yAxisPositionAnimation.value *
                  (constraints.maxHeight / 2 - 70)) +
          16 +
          (1 - fabIconFallAnimation.value) * 24,
      right: (xAxisPositionAnimation.value *
              (MediaQuery.of(context).size.width / 2 - 56)) -
          (actionIconTranslateAnimation.value * constraints.maxWidth / 4) +
          40,
      child: GestureDetector(
        onTap: () {
          // if (_controller.status == AnimationStatus.completed) {
          //   _controller.reverse();
          // } else {
          //   _controller.forward();
          // }
        },
        child: IgnorePointer(
          child: Container(
            // color: Colors.red,
            height: 32,
            width: 32,
            // margin: const EdgeInsets.all(24),
            child: FilterIcon(),
          ),
        ),
      ),
    );
  }
}
