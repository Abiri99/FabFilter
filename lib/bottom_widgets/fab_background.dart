import 'package:flutter/material.dart';

class FabBackground extends StatefulWidget {
  final AnimationController filterAnimationController;
  final AnimationController animationController;

  // final Animation<double> fabRevealAnimation;
  // final Animation<double> fadeOutAnimation;
  // final Animation<double> xAxisPositionAnimation;
  // final Animation<double> yAxisPositionAnimation;
  // final Animation<double> fabWrapperSizeAnimation;

  final BoxConstraints constraints;
  final double topIndicatorListViewHeight;
  final double fabWidth;
  final double fabMargin;
  final Function tapCallback;
  final double fpvHeight;

  FabBackground({
    Key key,
    @required this.constraints,
    @required this.topIndicatorListViewHeight,
    @required this.fabWidth,
    @required this.fabMargin,
    @required this.tapCallback,
    @required this.filterAnimationController,
    @required this.animationController,
    // @required this.fabRevealAnimation,
    // @required this.fadeOutAnimation,
    // @required this.xAxisPositionAnimation,
    // @required this.yAxisPositionAnimation,
    // @required this.fabWrapperSizeAnimation,
    @required this.fpvHeight,
  })  : assert(constraints != null),
        assert(topIndicatorListViewHeight != null),
        assert(fabWidth != null),
        assert(fabMargin != null),
        assert(tapCallback != null),
        assert(fpvHeight != null),
        assert(animationController != null),
        assert(filterAnimationController != null),
        super(key: key);

  @override
  FabBackgroundState createState() => FabBackgroundState();
}

class FabBackgroundState extends State<FabBackground> {

  Animation<double> revealAnimation;
  Animation<double> fadeOutAnimation;
  Animation<double> xAxisPositionAnimation;
  Animation<double> yAxisPositionAnimation;
  Animation<double> wrapperSizeAnimation;

  animationListener() {
    setState(() {});
  }

  @override
  void initState() {
    revealAnimation = CurvedAnimation(
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
        curve: Curves.easeIn,
      ),
    );
    wrapperSizeAnimation = CurvedAnimation(
      parent: widget.filterAnimationController,
      curve: Interval(
        0.0,
        0.15,
        curve: Curves.elasticIn,
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
    return ClipPath(
      clipper: FabBackgroundClipper(fpvHeight: widget.fpvHeight),
      child: GestureDetector(
        onTap: () {
          widget.tapCallback();
        },
        child: AnimatedBuilder(
          animation: widget.animationController,
          builder: (context, child) => Align(
            alignment: Alignment(
              // 0,0.5,
              1 - xAxisPositionAnimation.value,
              // 0.5,
              1 -
                  yAxisPositionAnimation.value *
                      widget.fpvHeight /
                      (widget.constraints.maxHeight),
            ),
            child: child,
          ),
          child: AnimatedBuilder(
            animation: revealAnimation,
            builder: (context, _) => Transform.scale(
              // scale: 1,
              scale: 1 + 7 * revealAnimation.value,
              child: Container(
                height: widget.fabWidth,
                width: widget.fabWidth,
                margin: EdgeInsets.all(
                  (1 - revealAnimation.value) * widget.fabMargin,
                ),
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: SizedBox(),
                ),
                decoration: BoxDecoration(
                  // color: Colors.red,
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.all(
                    Radius.circular(500),
                    // Radius.circular(500 * (1 - widget.fabRevealAnimation.value)),
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
    // return Positioned(
    //   // right: widget.fadeOutAnimation.value > 0 ? -100 : 0,
    //   // bottom: widget.fadeOutAnimation.value > 0 ? -100 : 0,
    //   // top: widget.fadeOutAnimation.value > 0 ? -100 : 0,
    //   // left: widget.fadeOutAnimation.value > 0 ? -100 : 0,
    //   right: 0,
    //   left: 0,
    //   bottom: 0,
    //   top: widget.topIndicatorListViewHeight - 100,
    //   child: Container(
    //     child: Align(
    //       alignment: Alignment(
    //         // 1 - (100 / mq.size.width) - xAxisPositionAnimationValue,
    //         // 1 - (100 / (mq.size.width - widget.topIndicatorListViewHeight)) - yAxisPositionAnimationValue,
    //         (1 - widget.xAxisPositionAnimation.value),
    //         (1 - widget.yAxisPositionAnimation.value),
    //       ),
    //       child: GestureDetector(
    //         onTap: () {
    //           widget.tapCallback();
    //         },
    //         child: Transform.scale(
    //           scale: 1,
    //           // scale: widget.fadeOutAnimation.value > 0 ? 1.5 : 1,
    //           child: Align(
    //             heightFactor: 0.1,
    //             widthFactor: 0.1,
    //             child: Container(
    //               // height: (widget.fabRevealAnimation.value) *
    //               //         (widget.constraints.maxHeight -
    //               //             widget.topIndicatorListViewHeight) +
    //               //     (1 - widget.fabRevealAnimation.value) * widget.fabWidth -
    //               //     (widget.fabWrapperSizeAnimation.value *
    //               //         (widget.constraints.maxHeight -
    //               //             widget.topIndicatorListViewHeight -
    //               //             82)),
    //               // width:
    //               //     (widget.fabRevealAnimation.value) * (widget.constraints.maxWidth) +
    //               //         (1 - widget.fabRevealAnimation.value) * widget.fabWidth -
    //               //         (widget.fabWrapperSizeAnimation.value *
    //               //             (widget.constraints.maxWidth - 82)),
    //               margin: EdgeInsets.all(
    //                   (1 - widget.fabRevealAnimation.value) * widget.fabMargin),
    //               padding: const EdgeInsets.all(32),
    //               child: Center(
    //                 child: SizedBox(),
    //               ),
    //               decoration: BoxDecoration(
    //                 color: Theme.of(context).primaryColorDark,
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(widget.fadeOutAnimation.value > 0
    //                       ? 10000
    //                       : (1 - widget.fabRevealAnimation.value) * 500),
    //                 ),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black26,
    //                     offset: Offset(0, 15),
    //                     blurRadius: 15,
    //                     spreadRadius: -8,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class FabBackgroundClipper extends CustomClipper<Path> {
  final double fpvHeight;

  FabBackgroundClipper({this.fpvHeight});

  @override
  Path getClip(Size size) {
    Path path = Path()
      // ..lineTo(0, size.height)
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - fpvHeight)
      ..lineTo(0, size.height - fpvHeight)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(FabBackgroundClipper oldClipper) => true;
}
