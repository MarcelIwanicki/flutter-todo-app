import 'package:flutter/material.dart';

const CURVE_HEIGHT = 160.0;

class BottomBackgroundShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CURVE_HEIGHT,
      child: CustomPaint(
        painter: _BottomBackgroundShapePainter(),
      ),
    );
  }
}

class _BottomBackgroundShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Color.fromRGBO(3,218,153, 1);

    Offset bottomLeft = Offset(0, size.height * 10);
    Offset topLeft = Offset(0, size.height - size.height * 0.1 - 60);
    Offset bottomRight = Offset(size.width, size.height * 10);
    Offset topRight = Offset(size.width, size.height * 0.5 - 25);


    Path path = Path()
      ..moveTo(bottomLeft.dx, bottomLeft.dy)
      ..lineTo(topLeft.dx, topLeft.dy + 40)
      ..quadraticBezierTo((topLeft.dx + topRight.dx) / 4, topLeft.dy + 40, (topLeft.dx + topRight.dx) / 2, (topLeft.dy + topLeft.dy) / 2 + 5)
      ..quadraticBezierTo(topRight.dx - (topLeft.dx + topRight.dx) / 4, topRight.dy, topRight.dx, topRight.dy)
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}