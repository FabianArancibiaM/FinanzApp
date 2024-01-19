import 'package:flutter/material.dart';

class HeaderWavesScreen extends StatelessWidget {
  const HeaderWavesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return headerWaves();
  }
}

class headerWaves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWaves(),
      ),
    );
  }
}

class _HeaderWaves extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();
    lapiz.color = Color.fromRGBO(38, 251, 212, 1);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 50;

    final path = new Path();
    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.25,
        size.width * 0.5, size.height * 0.20);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.15, size.width, size.height * 0.20);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
