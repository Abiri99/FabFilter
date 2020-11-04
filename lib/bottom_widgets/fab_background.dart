import 'package:flutter/material.dart';

class FabBackground extends StatefulWidget {
  final BoxConstraints constraints;
  final double topIndicatorListViewHeight;
  final double fabWidth;
  final double fabMargin;
  final Function tapCallback;

  FabBackground({
    Key key,
    @required this.constraints,
    @required this.topIndicatorListViewHeight,
    @required this.fabWidth,
    @required this.fabMargin,
    @required this.tapCallback,
  })  : assert(constraints != null),
        assert(topIndicatorListViewHeight != null),
        assert(fabWidth != null),
        assert(fabMargin != null),
        assert(tapCallback != null),
        super(key: key);

  @override
  FabBackgroundState createState() => FabBackgroundState();
}

class FabBackgroundState extends State<FabBackground> {
  double fabRevealAnimationValue;

  setFabRevealAnimationValue(double value) {
    setState(() {
      fabRevealAnimationValue = value;
    });
  }

  double fadeOutAnimationValue;

  setFadeOutAnimation(double value) {
    setState(() {
      fadeOutAnimationValue = value;
    });
  }

  double xAxisPositionAnimationValue;

  setXAxisPositionAnimationValue(double value) {
    setState(() {
      xAxisPositionAnimationValue = value;
    });
  }

  double yAxisPositionAnimationValue;

  setYAxisPositionAnimationValue(double value) {
    setState(() {
      yAxisPositionAnimationValue = value;
    });
  }

  double fabWrapperSizeAnimationValue;

  setFabWrapperSizeAnimationValue(double value) {
    setState(() {
      fabWrapperSizeAnimationValue = value;
    });
  }

  @override
  void initState() {
    fabRevealAnimationValue = 0.0;
    fadeOutAnimationValue = 0.0;
    xAxisPositionAnimationValue = 0.0;
    yAxisPositionAnimationValue = 0.0;
    fabWrapperSizeAnimationValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Positioned(
      right: fadeOutAnimationValue > 0 ? -100 : 0,
      bottom: fadeOutAnimationValue > 0 ? -100 : 0,
      top: fadeOutAnimationValue > 0 ? -100 : 0,
      left: fadeOutAnimationValue > 0 ? -100 : 0,
      // right: -100,
      // left: -100,
      // bottom: -100,
      // top: widget.topIndicatorListViewHeight - 100,
      child: Container(
        child: Align(
          alignment: Alignment(
            // 1 - (100 / mq.size.width) - xAxisPositionAnimationValue,
            // 1 - (100 / (mq.size.width - widget.topIndicatorListViewHeight)) - yAxisPositionAnimationValue,
            (1 - xAxisPositionAnimationValue),
            (1 - yAxisPositionAnimationValue),
          ),
          child: GestureDetector(
            onTap: () {
              widget.tapCallback();
            },
            child: Transform.scale(
              scale: fadeOutAnimationValue > 0 ? 1.5 : 1,
              child: Container(
                height: (fabRevealAnimationValue) *
                        (widget.constraints.maxHeight -
                            widget.topIndicatorListViewHeight) +
                    (1 - fabRevealAnimationValue) * widget.fabWidth
                    - (fabWrapperSizeAnimationValue * (widget.constraints.maxHeight - widget.topIndicatorListViewHeight - 82)),
                width: (fabRevealAnimationValue) * (widget.constraints.maxWidth) +
                    (1 - fabRevealAnimationValue) * widget.fabWidth
                - (fabWrapperSizeAnimationValue * (widget.constraints.maxWidth - 82)),
                margin: EdgeInsets.all(
                    (1 - fabRevealAnimationValue) * widget.fabMargin),
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: SizedBox(),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.all(
                    Radius.circular(fadeOutAnimationValue > 0 ? 10000 : (1 - fabRevealAnimationValue) * 500),
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
          ),
        ),
      ),
    );
  }
}
