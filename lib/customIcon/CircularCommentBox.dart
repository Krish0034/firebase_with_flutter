import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyPaint.dart';

class CircularCommentBox extends StatefulWidget {
  /// Size of CommentBox widget
  final double size;
  /// size of circle
  final double circleSize;
  /// colors of circle
  final CustomsColors circleColor;
  /// tap call back of CommentBox
 // final LikeButtonTapCallback? onTap;
  const CircularCommentBox({Key? key, required this.size, required this.circleSize, required this.circleColor}) : super(key: key);

  @override
  State<CircularCommentBox> createState() => _CircularCommentBoxState();
}

class _CircularCommentBoxState extends State<CircularCommentBox> with TickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: MyPaint(),
        child: Container(),
      ),
    );
  }
}
