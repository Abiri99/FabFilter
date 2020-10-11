import 'package:flutter/cupertino.dart';

class CustomSeekBarPainter extends CustomPainter {
  final double firstThumbX;
  final double secThumbX;
  final Color defaultLineColor;
  final Color progressLineColor;
  final Color thumbColor;

  CustomSeekBarPainter({
    this.firstThumbX,
    this.secThumbX,
    this.defaultLineColor,
    this.progressLineColor,
    this.thumbColor,
  })  : assert(firstThumbX != null),
        assert(secThumbX != null),
        assert(defaultLineColor != null),
        assert(progressLineColor != null),
        assert(thumbColor != null);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12
      ..color = defaultLineColor;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(firstThumbX, size.height / 2),
      paint,
    );
    canvas.drawLine(
      Offset(secThumbX, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12
      ..color = progressLineColor;
    canvas.drawLine(
      Offset(firstThumbX, size.height / 2),
      Offset(secThumbX, size.height / 2),
      paint,
    );

    paint = Paint()
      ..style = PaintingStyle.fill
      ..color = thumbColor;
    canvas.drawCircle(Offset(firstThumbX, size.height/2), 24, paint);
    canvas.drawCircle(Offset(secThumbX, size.height/2), 24, paint);

    paint = null;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
    // return oldDelegate != this;
  }
}
