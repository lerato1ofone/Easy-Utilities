import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/data/bills.dart';
import 'package:flutter/material.dart';

class BillsScreen extends StatefulWidget {
  BillsScreen() : super();

  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  @override
  Widget build(BuildContext context) {
    final bills = Bills;

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
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 90.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Just bought water \nor electricity?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.black12),
                      Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.black12),
                      Shadow(
                          // topRight
                          offset: Offset(0.5, 0.5),
                          color: Colors.black12),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.black12),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    children: [
                      Text(
                        'Add it right here',
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                      SizedBox(width: 30),
                      FlatButton(
                        minWidth: 105.0,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        splashColor: HexColor.fromHex('#12E2E2'),
                        onPressed: () {},
                        child: Text("Add"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 290.0,
              right: 15.0,
              left: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HexColor.fromHex('#12E2E2'),
                    fontSize: 20.0,
                    fontFamily: 'Nunito',
                    letterSpacing: 0.6
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ListTile(
                        title: Text('R ${bills[index].amount}'),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
