import 'package:easy_utilities/core/hex_color.dart';
import 'package:flutter/material.dart';

class BillsScreen extends StatefulWidget {
  // This value is passed into this widget to determine which bill to add (Electricity or Water bill)
  final String bill;

  BillsScreen({
    Key key,
    @required this.bill,
  }) : super(key: key);

  @override
  _BillsScreenState createState() => _BillsScreenState(bill);
}

class _BillsScreenState extends State<BillsScreen> {
  String bill;

  //constructor
  _BillsScreenState(this.bill);

  @override
  Widget build(BuildContext context) {
    final String assetName = '../assets/images/backdrop.svg';

    return Scaffold(
      backgroundColor: HexColor.fromHex('#4A4040'),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
        ],
      )
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    // Sets properties to paint
    paint.color = HexColor.fromHex('#12E2E2');
    paint.style = PaintingStyle.fill;

    // Draws the path
    var path = Path();

    path.moveTo(0, size.height * 0.12);
    path.quadraticBezierTo(size.width * 0.125, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 1.25);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}