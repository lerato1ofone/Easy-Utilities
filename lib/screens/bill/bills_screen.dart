import 'package:easy_utilities/constants.dart';
import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/bill.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/services/database.dart';
import 'package:easy_utilities/widgets/latest_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  Future<List<BillData>> bills;

  @override
  void initState() {
    super.initState();
    bills = DatabaseService(uid: widget.user.uid).billsData;

    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double addBillHeight = size.height * 0.35;

    return Scaffold(
      backgroundColor: HexColor.fromHex('#ffffff'),
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
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                shadows: [
                                  Shadow(
                                      // bottomLeft
                                      offset: Offset(-1.5, -1.5),
                                      color: Colors.black),
                                  Shadow(
                                      // bottomRight
                                      offset: Offset(1.5, -1.5),
                                      color: Colors.black12),
                                  Shadow(
                                      // topRight
                                      offset: Offset(0.5, 0.5),
                                      color: Colors.black),
                                  Shadow(
                                      // topLeft
                                      offset: Offset(-1.5, 1.5),
                                      color: Colors.black12),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                minWidth: 200.0,
                                height: 45.0,
                                color: HexColor.fromHex('#FFD2E8'),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: HexColor.fromHex('#2389DA'),
                                        width: 1.5,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(18)),
                                splashColor: HexColor.fromHex('#12E2E2'),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/add',
                                      arguments: widget.user);
                                },
                                child: Text(
                                  "Add it right here",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      letterSpacing: 0.5,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500),
                                ),
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
                            style: eTitleText,
                          ),
                          IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.filter,
                                color: Colors.white70,
                                size: 20.0,
                              ),
                              onPressed: null),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Expanded(
                        child: FutureBuilder<List<BillData>>(
                          future: bills,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container(
                                child: Text('There was an error'),
                              );
                            }

                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Container(
                                child:
                                    CircularProgressIndicator(), // Todo: add custom loader
                              );
                            } else {
                              print('building');

                              List<BillData> bills = snapshot.data ?? [];

                              return ListView.separated(
                                controller: controller,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: bills == null ? 0 : bills.length,
                                itemBuilder: (context, i) {
                                  if (bills[i].type == BillType.electricity) {
                                    return LatestTransactionCard(
                                      tileColor: HexColor.fromHex('#00FFFF'),
                                      icon:
                                          './assets/icons/electricity-icon.svg',
                                      title: bills[i].user.name,
                                      subtitle:
                                          '${monthsInYear[bills[i].date.month]} ${bills[i].date.day} | R ${bills[i].amount}',
                                      onPress: () =>
                                          {print('open transaction')},
                                    );
                                  } else {
                                    return LatestTransactionCard(
                                      tileColor: HexColor.fromHex('#00FFFF'),
                                      icon:
                                          './assets/icons/water-drop-icon.svg',
                                      title: bills[i].user.name,
                                      subtitle:
                                          '${monthsInYear[bills[i].date.month]} ${bills[i].date.day} | R ${bills[i].amount}',
                                      onPress: () =>
                                          {print('open transaction')},
                                    );
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                },
                              );
                            }
                          },
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
    return ListTile();
    // if (bill. == Constants.WATER) {
    //   return ListTile(
    //     leading: const Icon(
    //       Icons.water_damage,
    //       size: 45.0,
    //     ),
    //     title: Text(
    //       'R ${bills[index].amount} by ${bills[index].by}',
    //     ),
    //     subtitle: Text(DateFormat('dd MMMM yyyy').format(bills[index].date)),
    //   );
    // } else {
    //   return ListTile(
    //     leading: const Icon(
    //       Icons.power,
    //       size: 45.0,
    //     ),
    //     title: Text(
    //       'R ${bills[index].amount} by ${bills[index].by}',
    //     ),
    //     subtitle: Text(DateFormat('dd MMMM yyyy').format(bills[index].date)),
    //   );
    // }
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
