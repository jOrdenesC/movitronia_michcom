import 'package:flutter/material.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TEST PAGE"),
        centerTitle: true,
        backgroundColor: cyan,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: -math.pi / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "¿Sabías que...",
                  style: TextStyle(color: Colors.white, fontSize: 10.0.w),
                ),
              ],
            ),
          ),
          Transform.rotate(
            angle: -math.pi / 20,
            child: Container(
              width: 80.0.w,
              height: 20.0.h,
              decoration: BoxDecoration(
                  color: red,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
          ),
          // CustomPaint(
          //   child: Container(
          //     height: 10.0.h,
          //     width: 50.0.w,
          //   ),
          //   painter: CustomChatBubble(
          //     color: red,
          //     isOwn: true
          //   ),
          // )
        ],
      ),
    );
  }
}

class CustomChatBubble extends CustomPainter {
  CustomChatBubble({this.color, @required this.isOwn});

  final Color color;
  final bool isOwn;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color ?? Colors.blue;

    Path paintBubbleTail() {
      Path path;
      if (!isOwn) {
        path = Path()
          ..moveTo(10, size.height - 5)
          ..quadraticBezierTo(-5, size.height, -16, size.height - 4)
          ..quadraticBezierTo(-5, size.height - 5, 0, size.height - 17);
      }
      if (isOwn) {
        path = Path()
          ..moveTo(size.width - 6, size.height - 4)
          ..quadraticBezierTo(size.width + 10 + 5, size.height + 10,
              size.width + 26, size.height - 4)
          ..quadraticBezierTo(
              size.width + 5, size.height - 5, size.width, size.height - 17);
      }
      return path;
    }

    final RRect bubbleBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(20, 0, size.width, size.height - 10),
        Radius.circular(16));
    final Path bubbleTail = paintBubbleTail();

    canvas.drawRRect(bubbleBody, paint);
    canvas.drawPath(bubbleTail, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
