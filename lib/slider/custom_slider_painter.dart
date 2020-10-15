import 'package:flutter/cupertino.dart';

class CustomSliderPainter extends CustomPainter {
  final double thumbX;
  final Color defaultLineColor;
  final Color progressLineColor;
  final Color thumbColor;

  CustomSliderPainter({
    this.thumbX,
    this.defaultLineColor,
    this.progressLineColor,
    this.thumbColor,
  })  : assert(thumbX != null),
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
      Offset(thumbX, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12
      ..color = progressLineColor;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(thumbX, size.height / 2),
      paint,
    );

    paint = Paint()
      ..style = PaintingStyle.fill
      ..color = thumbColor;
    canvas.drawCircle(Offset(thumbX, size.height/2), 24, paint);
    paint = null;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
    // return oldDelegate != this;
  }
}
