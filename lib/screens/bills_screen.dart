import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/data/constants.dart';
import 'package:easy_utilities/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_utilities/data/bills.dart';

class BillsScreen extends StatefulWidget {
  BillsScreen() : super();

  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bills = Bills.bills;
    final Size size = MediaQuery.of(context).size;
    final double addBillHeight = size.height * 0.35;

    return Scaffold(
      backgroundColor: HexColor.fromHex('#4A4040'),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer ? 0 : size.height * 0.50,
                child: Wrap(
                  children: [
                    Stack(children: [
                      Container(
                        width: size.width,
                        height: addBillHeight,
                        child: CustomPaint(
                          painter: CurvePainter(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0, left: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Just bought water \nor electricity?',
                              style: TextStyle(
                                letterSpacing: 0.5,
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.0),
                                  ),
                                  SizedBox(width: 45.0),
                                  // ignore: deprecated_member_use
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
                    ]),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 18.0, right: 25.0),
                child: Container(
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'History Purchases',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: HexColor.fromHex('#12E2E2'),
                                fontSize: 20.0,
                                fontFamily: 'Nunito',
                                letterSpacing: 0.6),
                          ),
                          IconButton(
                              icon: FaIcon(FontAwesomeIcons.filter, color: Colors.white70, size: 20.0,),
                              onPressed: null)
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ListView.separated(
                            controller: controller,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: bills.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.indigo[100],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: CreateListTile.createTile(
                                    bills[index], index, bills),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateListTile extends ListTile {
  static Widget createTile(Bill bill, index, List<Bill> bills) {
    if (bill.type == Constants.WATER) {
      return ListTile(
        leading: const Icon(
          Icons.water_damage,
          size: 45.0,
        ),
        title: Text(
          'R ${bills[index].amount} by ${bills[index].by}',
        ),
        subtitle: Text(DateFormat('dd MMMM yyyy').format(bills[index].date)),
      );
    } else {
      return ListTile(
        leading: const Icon(
          Icons.power,
          size: 45.0,
        ),
        title: Text(
          'R ${bills[index].amount} by ${bills[index].by}',
        ),
        subtitle: Text(DateFormat('dd MMMM yyyy').format(bills[index].date)),
      );
    }
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
