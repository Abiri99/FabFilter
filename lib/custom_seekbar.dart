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
  double _firstVal;
  double _secVal;

  double _firstThumbGestureStartPosition;
  double _secThumbGestureStartPosition;

  @override
  void initState() {
    _firstVal = 0;
    _secVal = widget.width - 48;

    _firstThumbGestureStartPosition = _firstVal;
    _secThumbGestureStartPosition = _secVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(),
      color: Colors.brown,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Line(
            color: Color(0xff297295),
          ),
          Positioned(
            left: _secVal,
            bottom: 0,
            top: 0,
            child: GestureDetector(
              onHorizontalDragStart: (dragStartDetails) {
                _secThumbGestureStartPosition = dragStartDetails.localPosition.dx;
              },
              onHorizontalDragUpdate: (dragUpdateDetails) {
                var position = dragUpdateDetails.globalPosition.dx;
                var diff = position - _secThumbGestureStartPosition;
                // if (position > widget.width || position <= _firstVal + 48 + 4)
                //   return
                setState(() {
                  _secVal = (_secVal + diff).clamp(_firstVal + 48, widget.width - 48).toDouble();
                  // _secVal = dragUpdateDetails.localPosition.dx;
                });
              },
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
          ),
          Positioned(
            left: _firstVal,
            bottom: 0,
            top: 0,
            child: GestureDetector(
              onHorizontalDragStart: (dragStartDetails) {
                _firstThumbGestureStartPosition = dragStartDetails.localPosition.dx;
              },
              onHorizontalDragUpdate: (dragUpdateDetails) {
                print("pos: ${dragUpdateDetails.localPosition}");
                var position = dragUpdateDetails.localPosition.dx;
                var diff = position - _firstThumbGestureStartPosition;
                // if (position < 0 || position >= _secVal - 48 - 4)
                //   return
                setState(() {
                  // _firstVal = dragUpdateDetails.localPosition.dx;
                  _firstVal = (_firstVal + diff).clamp(0, _secVal - 48).toDouble();
                });
              },
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
          ),
        ],
      ),
    );
  }
}
