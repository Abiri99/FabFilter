import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

import 'custom_range_slider_painter.dart';
import 'custom_slider_painter.dart';

class CustomSlider extends StatefulWidget {
  final double width;
  final double maxValue;
  final double minValue;
  final double initialValue;
  final Function(int value) onValueChange;

  CustomSlider({
    @required this.width,
    this.maxValue = 1.0,
    this.minValue = 0.0,
    this.initialValue,
    @required this.onValueChange,
  })  : assert(width != null),
        assert(maxValue != null),
        assert(onValueChange != null),
        assert(minValue != null);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double thumbStartX;
  int currentNode;

  bool stateChanged;

  @override
  void initState() {
    stateChanged = false;
    thumbStartX = widget.initialValue.clamp(widget.minValue, widget.maxValue) ?? widget.width / 2;
    currentNode = 0;
    super.initState();
  }

  _handleDragStart(DragStartDetails dragStartDetails) {
    currentNode = _detectNode(dragStartDetails);
  }

  _detectNode(DragStartDetails details) {
    var position = details.localPosition.dx;
    if (position >= thumbStartX && position <= thumbStartX + 48) return 1;
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: 64,
      width: widget.width,
      margin: const EdgeInsets.symmetric(
        // horizontal: 6,
        // vertical: 32,
      ),
      child: GestureDetector(
        onHorizontalDragStart: (dragStartDetails) {
          _handleDragStart(dragStartDetails);
        },
        onHorizontalDragUpdate: (dragUpdateDetails) {
          var diff = dragUpdateDetails.delta.dx;
          if (currentNode == 1)
            setState(() {
              stateChanged = true;
              thumbStartX = (thumbStartX + diff).clamp(0.0, widget.width - 48);
            });
        },
        onHorizontalDragEnd: (dragEndDetails) {
          var value = ((thumbStartX + 24) * (widget.maxValue - widget.minValue) / (widget.width));
          print("value: $value");
          widget.onValueChange(value.floor());
        },
        child: CustomPaint(
          size: Size(widget.width, 64),
          painter: CustomSliderPainter(
            thumbX: thumbStartX + 24,
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
    //         thumbStartX =
    //             (thumbStartX + diff).clamp(0.0, secThumbStartX - 48);
    //       });
    //     else if (currentNode == 2)
    //       setState(() {
    //         stateChanged = true;
    //         secThumbStartX = (secThumbStartX + diff)
    //             .clamp(thumbStartX + 48, widget.width - 48);
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
    //           left: thumbStartX,
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
