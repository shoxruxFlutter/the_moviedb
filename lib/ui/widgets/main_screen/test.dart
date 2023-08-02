import 'dart:math';

import 'package:flutter/material.dart';


class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child:  const RadialPercentWidget(
          percent: 0.72,
          
          lineColor: Color.fromARGB(255, 37, 203, 103),
          freeColor: Color.fromARGB(255, 25, 54, 31),
          fillColor: Color.fromARGB(255, 10, 23, 25),
          lineWidth: 5,

          child: Text('72%', style: TextStyle(color: Colors.white),),
        )
      )
    );
  }
 
}

class RadialPercentWidget extends StatelessWidget{
  final Widget child;
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;
  const RadialPercentWidget({super.key, required this.child, required this.percent, required this.fillColor, required this.lineColor, required this.freeColor, required this.lineWidth});

  @override
  Widget build(BuildContext context) {
      return Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: MyPainter(freeColor: freeColor, fillColor: fillColor, lineColor: lineColor, lineWidth: lineWidth, percent: percent)),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: Center(child: child),
          ),
        ],
      );
  }

}

// fillColor: Color.fromARGB(255, 10, 23, 25),
// lineColor: Color.fromARGB(255, 37, 203, 103),
// freeColor: Color.fromARGB(255, 25, 54, 31),
// paint.style = PaintingStyle.stroke;
// paint.strokeWidth = 10;
// canvas.drawCircle(Offset(size.width/2, size.height/2), size.width/2, paint);
// canvas.drawRect(Offset.zero & const Size(30, 30), paint);

class MyPainter extends CustomPainter{
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  MyPainter({required this.percent, required this.fillColor, required this.lineColor, required this.freeColor, required this.lineWidth});

  @override 
  void paint(Canvas canvas, Size size) {
    Rect arcRect = calculateArcsRect(size);

    drawBackground(canvas, size);

    
    drawFreeArc(canvas, arcRect);

    drawLineColor(canvas, arcRect);

    
  }

  void drawLineColor(Canvas canvas, Rect arcRect) {
    final paint = Paint(); 
    paint.color = lineColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, -pi / 2, pi * 2 * percent, false, paint,);
  }

  void drawFreeArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = freeColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    canvas.drawArc(arcRect, pi * 2 * percent - (pi / 2) , pi * 2 * (1.0 -percent), false, paint,);
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = fillColor;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size) {
    const lineMargin = 3;
    final offset = lineWidth / 2 + lineMargin;
    final arcRect = Offset(offset, offset) & Size(size.width - offset * 2, size.height - offset * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}