import 'package:flutter/material.dart';

class FabContainer extends StatelessWidget {
  final AnimationController controller;
  final Animation fabRevealAnimation;
  final Animation yAxisPositionAnimation;
  final Animation xAxisPositionAnimation;
  final BoxConstraints constraints;

  FabContainer({
    this.controller,
    this.fabRevealAnimation,
    this.yAxisPositionAnimation,
    this.xAxisPositionAnimation,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // bottom: 0,
      // right: 0,
      bottom: (1 - fabRevealAnimation.value) *
          (yAxisPositionAnimation.value * (constraints.maxHeight / 2 - 70)),
      right: (1 - fabRevealAnimation.value) *
          (xAxisPositionAnimation.value *
              (MediaQuery.of(context).size.width / 2 - 56)),

      child: GestureDetector(
        onTap: () {
          if (controller.status == AnimationStatus.completed)
            controller.reverse();
          else
            controller.forward();
        },
        child: Container(
          height: (fabRevealAnimation.value) * (constraints.maxHeight - 64) +
              (1 - fabRevealAnimation.value) * 64,
          width: (fabRevealAnimation.value) * constraints.maxWidth +
              (1 - fabRevealAnimation.value) * 64,
          margin: EdgeInsets.all((1 - fabRevealAnimation.value) * 24),
          padding: const EdgeInsets.all(32),
          child: Center(
            child: SizedBox(),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.all(
              Radius.circular((1 - fabRevealAnimation.value) * 500),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 15),
                blurRadius: 15,
                spreadRadius: -8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
