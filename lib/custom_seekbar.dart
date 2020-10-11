import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class CustomSeekBar extends StatefulWidget {
  final double width;

  CustomSeekBar({
    @required this.width,
  }) : assert(width != null);

  @override
  _CustomSeekBarState createState() => _CustomSeekBarState();
}

class _CustomSeekBarState extends State<CustomSeekBar> {
  //New
  double firstThumbStartX;
  double secThumbStartX;
  int currentNode;

  @override
  void initState() {
    firstThumbStartX = 0;
    secThumbStartX = widget.width - 48;
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
    return GestureDetector(
      onHorizontalDragStart: (dragStartDetails) {
        _handleDragStart(dragStartDetails);
      },
      onHorizontalDragUpdate: (dragUpdateDetails) {
        var diff = dragUpdateDetails.delta.dx;
        if (currentNode == 1)
          setState(() {
            firstThumbStartX = (firstThumbStartX + diff).clamp(0.0, secThumbStartX - 48);
          });
        else if (currentNode == 2)
          setState(() {
            secThumbStartX = (secThumbStartX + diff).clamp(firstThumbStartX + 48, widget.width - 48);
          });

        // _handleDrag(dragUpdateDetails);


        // var position = dragUpdateDetails.localPosition.dx;
        // print("pos: $position");
        // var diff = dragUpdateDetails.delta.dx;
        // if (position >= _firstVal - 24 && position <= _firstVal + 24) {
        //   print("moving first with diff: $diff");
        //   setState(() {
        //     _firstVal = (_firstVal + diff).clamp(24, _secVal - 48).toDouble();
        //   });
        // } else if (position >= _secVal - 24 && position <= _secVal + 24) {
        //   print("moving sec with diff: $diff");
        //   _secVal = (_secVal + diff).clamp(_firstVal + 48, widget.width - 24).toDouble();
        // }
      },
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(),
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Line(
              color: Color(0xff297295),
            ),
            Positioned(
              left: secThumbStartX,
              bottom: 0,
              top: 0,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.red,
                  // color: Color(0xff297295),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
            Positioned(
              left: firstThumbStartX,
              bottom: 0,
              top: 0,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Color(0xff297295),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
