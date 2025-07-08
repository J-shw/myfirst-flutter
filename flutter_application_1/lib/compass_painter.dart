import 'package:flutter/material.dart';
import 'dart:math' as math;

class CompassPainter extends CustomPainter {
  final double angle;
  final ColorScheme colorScheme;

  CompassPainter({required this.angle, required this.colorScheme});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    final cardinalTextOffset = radius * 0.55;
    final cardinalFontSize = radius * 0.15;
    final cardinalTextColor = colorScheme.onSurface;

    // N
    final nTextPainter = TextPainter(
      text: TextSpan(text: 'N', style: TextStyle(color: cardinalTextColor, fontSize: cardinalFontSize, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    );
    nTextPainter.layout();
    nTextPainter.paint(
      canvas,
      Offset(center.dx - nTextPainter.width / 2, center.dy - cardinalTextOffset - nTextPainter.height / 0.5),
    );

    // --- Compass Needle (Red & Black Triangles) ---
    final needleRedPaint = Paint()
      ..color = Colors.red[700]! // Main red body of the needle
      ..style = PaintingStyle.fill;

    final needleBlackPaint = Paint()
      ..color = Colors.black87 // Black tail of the needle
      ..style = PaintingStyle.fill;

    canvas.save(); // Save the canvas state before rotation

    canvas.translate(center.dx, center.dy); // Move origin to center
    canvas.rotate(angle * math.pi / 180);
    canvas.translate(-center.dx, -center.dy);

    final needleWidth = radius * 0.1;
    final needleLengthRed = radius * 0.65;
    final needleLengthBlack = radius * 0.60;

    final Path redNeedlePath = Path();
    redNeedlePath.moveTo(center.dx, center.dy - needleLengthRed); 
    redNeedlePath.lineTo(center.dx + needleWidth / 2, center.dy);
    redNeedlePath.lineTo(center.dx - needleWidth / 2, center.dy);
    redNeedlePath.close();
    canvas.drawPath(redNeedlePath, needleRedPaint);

    final Path blackNeedlePath = Path();
    blackNeedlePath.moveTo(center.dx, center.dy + needleLengthBlack);
    blackNeedlePath.lineTo(center.dx + needleWidth / 2, center.dy);
    blackNeedlePath.lineTo(center.dx - needleWidth / 2, center.dy); 
    blackNeedlePath.close();
    canvas.drawPath(blackNeedlePath, needleBlackPaint);

    canvas.restore();

    final pivotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.03, pivotPaint); // Small white circle
  }

  @override
  bool shouldRepaint(covariant CompassPainter oldDelegate) {
    return oldDelegate.angle != angle || oldDelegate.colorScheme != colorScheme;
  }
}