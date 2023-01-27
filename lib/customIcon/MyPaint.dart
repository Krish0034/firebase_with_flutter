import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/cupertino.dart';

class MyPaint extends CustomPainter
{
  @override
  void paint(Canvas canvas, Size size) {
    final paint= Paint();
    final path= Path();
    paint.style=PaintingStyle.stroke;
    paint.color=CustomsColors.c6;
    path.quadraticBezierTo(10, 10, 10, 10);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}