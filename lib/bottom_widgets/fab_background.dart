import 'package:flutter/material.dart';

class FabBackground extends StatefulWidget {
  final Animation<double> fabRevealAnimation;
  final Animation<double> fadeOutAnimation;
  final Animation<double> xAxisPositionAnimation;
  final Animation<double> yAxisPositionAnimation;
  final Animation<double> fabWrapperSizeAnimation;

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
    @required this.fabRevealAnimation,
    @required this.fadeOutAnimation,
    @required this.xAxisPositionAnimation,
    @required this.yAxisPositionAnimation,
    @required this.fabWrapperSizeAnimation,
    @required this.fpvHeight,
  })  : assert(constraints != null),
        assert(topIndicatorListViewHeight != null),
        assert(fabWidth != null),
        assert(fabMargin != null),
        assert(tapCallback != null),
        assert(fabRevealAnimation != null),
        assert(fadeOutAnimation != null),
        assert(xAxisPositionAnimation != null),
        assert(yAxisPositionAnimation != null),
        assert(fabWrapperSizeAnimation != null),
        assert(fpvHeight != null),
        super(key: key);

  @override
  FabBackgroundState createState() => FabBackgroundState();
}

class FabBackgroundState extends State<FabBackground> {
  animationListener() {
    setState(() {});
  }

  @override
  void initState() {
    widget.yAxisPositionAnimation.addListener(animationListener);
    widget.xAxisPositionAnimation.addListener(animationListener);
    widget.fabRevealAnimation.addListener(animationListener);
    widget.fadeOutAnimation.addListener(animationListener);
    widget.fabWrapperSizeAnimation.addListener(animationListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.yAxisPositionAnimation.removeListener(animationListener);
    widget.xAxisPositionAnimation.removeListener(animationListener);
    widget.fabRevealAnimation.removeListener(animationListener);
    widget.fadeOutAnimation.removeListener(animationListener);
    widget.fabWrapperSizeAnimation.removeListener(animationListener);
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
        child: Align(
          alignment: Alignment(
            // 0,0.5,
            1 - widget.xAxisPositionAnimation.value,
            // 0.5,
            1 - widget.yAxisPositionAnimation.value * widget.fpvHeight/(widget.constraints.maxHeight),
          ),
          child: Transform.scale(
            // scale: 1,
            scale: 1 + 7 * widget.fabRevealAnimation.value,
            child: Container(
              height: widget.fabWidth,
              width: widget.fabWidth,
              margin: EdgeInsets.all(
                (1 - widget.fabRevealAnimation.value) * widget.fabMargin,
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