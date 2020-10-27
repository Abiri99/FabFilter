import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

import 'custom_range_slider_painter.dart';

class CustomRangeSlider extends StatefulWidget {
  final double width;
  final double initialFirstThumbX;
  final double initialSecondThumbX;
  final Function(double v1, double v2) onRangeChanged;

  CustomRangeSlider({
    @required this.width,
    @required this.onRangeChanged,
    this.initialFirstThumbX,
    this.initialSecondThumbX,
  })  : assert(width != null),
        assert(onRangeChanged != null);

  @override
  _CustomRangeSliderState createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  double firstThumbStartX;
  double secThumbStartX;
  int currentNode;

  bool stateChanged;

  @override
  void initState() {
    stateChanged = false;
    firstThumbStartX = widget.initialFirstThumbX != null ? widget.initialFirstThumbX - 24 : 0;
    secThumbStartX = widget.initialSecondThumbX != null ? widget.initialSecondThumbX - 24 : widget.width - 48;
    currentNode = 0;
    super.initState();
  }

  _handleDragStart(DragStartDetails dragStartDetails) {
    currentNode = _detectNode(dragStartDetails);
  }

  _detectNode(DragStartDetails details) {
    var position = details.localPosition.dx;
    if (position >= firstThumbStartX && position <= firstThumbStartX + 48)
      return 1;
    else if (position >= secThumbStartX && position <= secThumbStartX + 48)
      return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: 64,
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
        // vertical: 32,
      ),
      child: GestureDetector(
        onHorizontalDragStart: (dragStartDetails) {
          _handleDragStart(dragStartDetails);
        },
        onHorizontalDragUpdate: (dragUpdateDetails) {
          var diff = dragUpdateDetails.delta.dx;
          if (currentNode == 1) {
            setState(() {
              stateChanged = true;
              firstThumbStartX =
                  (firstThumbStartX + diff).clamp(0.0, secThumbStartX - 48);
            });
            widget.onRangeChanged(firstThumbStartX + 24, secThumbStartX + 24);
          } else if (currentNode == 2) {
            setState(() {
              stateChanged = true;
              secThumbStartX = (secThumbStartX + diff)
                  .clamp(firstThumbStartX + 48, widget.width - 48);
            });
            widget.onRangeChanged(firstThumbStartX + 24, secThumbStartX + 24);
          }
        },
        child: CustomPaint(
          painter: CustomRangeSliderPainter(
            firstThumbX: firstThumbStartX + 24,
            secThumbX: secThumbStartX + 24,
            defaultLineColor: Color(0xff1D668F),
            progressLineColor:
                stateChanged ? Color(0xff359DBA) : Color(0xff1D668F),
            thumbColor: stateChanged ? Color(0xff52D1E2) : Color(0xff297295),
          ),
        ),
      ),
    );

    // return GestureDetector(
    //   onHorizontalDragStart: (dragStartDetails) {
    //     _handleDragStart(dragStartDetails);
    //   },
    //   onHorizontalDragUpdate: (dragUpdateDetails) {
    //     var diff = dragUpdateDetails.delta.dx;
    //     if (currentNode == 1)
    //       setState(() {
    //         stateChanged = true;
    //         firstThumbStartX =
    //             (firstThumbStartX + diff).clamp(0.0, secThumbStartX - 48);
    //       });
    //     else if (currentNode == 2)
    //       setState(() {
    //         stateChanged = true;
    //         secThumbStartX = (secThumbStartX + diff)
    //             .clamp(firstThumbStartX + 48, widget.width - 48);
    //       });
    //   },
    //   child: Container(
    //     height: 48,
    //     margin: const EdgeInsets.symmetric(),
    //     child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Line(
    //           color: stateChanged ?  Color(0xff1D668F),
    //           height: 12,
    //           // color: Color(0xff297295),
    //         ),
    //         Positioned(
    //           left: secThumbStartX,
    //           bottom: 0,
    //           top: 0,
    //           child: Container(
    //             height: 48,
    //             width: 48,
    //             decoration: BoxDecoration(
    //               color: Color(0xff297295),
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(50),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: firstThumbStartX,
    //           bottom: 0,
    //           top: 0,
    //           child: Container(
    //             height: 48,
    //             width: 48,
    //             decoration: BoxDecoration(
    //               color: Color(0xff297295),
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(50),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
