import 'dart:math';

import 'package:flutter/material.dart';

class StripLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintPink = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final paintBlue = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    double stripeWidth = 4; // panjang garis
    double stripeSpace = 4; // Jarak antar garis
    double angle = 30; // Sudut kemiringan garis

    // Menghitung tinggi efektif ketika garis dimiringkan
    double effectiveHeight = size.height / cos(angle * pi / 180);
    double totalWidth = size.width + effectiveHeight * tan(angle * pi / 180);

    Path pinkPath = Path();
    Path bluePath = Path();

    bool isPink = true;
    for (double x = -effectiveHeight * tan(angle * pi / 180);
        x < totalWidth;
        x += stripeWidth + stripeSpace) {
      Path path = Path();
      path.moveTo(x, 0);
      path.lineTo(x + stripeWidth, 0);
      path.lineTo(x + stripeWidth + effectiveHeight * tan(angle * pi / 180),
          size.height);
      path.lineTo(x + effectiveHeight * tan(angle * pi / 180), size.height);
      path.close();

      if (isPink) {
        pinkPath.addPath(path, Offset.zero);
      } else {
        bluePath.addPath(path, Offset.zero);
      }

      isPink = !isPink; // Alternate between pink and blue
    }

    canvas.drawPath(pinkPath, paintPink);
    canvas.drawPath(bluePath, paintBlue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
