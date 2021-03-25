import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/core/routes/add_bill_arguments.dart';
import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:easy_utilities/widgets/quick_action_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_utilities/widgets/bills_stream_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 35.0, right: 35.0, top: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Good evening,\n${widget.user.name}.',
                        style: eBlackHeading,
                      ),
                      Container(
                        child: ProfilePicture(
                          disableIcon: true,
                          user: widget.user,
                          imageFile: null,
                        ),
                        height: 75,
                        width: 75,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 31,
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('./assets/images/separator.png'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Quick Actions', style: eTitleText),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 220,
                          width: 160,
                          child: QuickActionCard(
                            color: '#F664F7',
                            icon: './assets/icons/electricity-icon.svg',
                            text: 'Add electricity',
                            textColor: '#F6EEE0',
                            iconColor: '#F6EEE0',
                            onPress: () {
                              Navigator.of(context).pushNamed('/add',
                                  arguments: AddBillArguments(
                                      widget.user, BillType.electricity));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 220,
                          width: 160,
                          child: QuickActionCard(
                            color: '#DA7423',
                            icon: './assets/icons/water-drop-icon.svg',
                            textColor: '#ffffff',
                            iconColor: '#ffffff',
                            text: 'Add water',
                            onPress: () {
                              Navigator.of(context).pushNamed('/add',
                                  arguments: AddBillArguments(
                                      widget.user, BillType.water));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 220,
                          width: 160,
                          child: QuickActionCard(
                            color: '#2389DA',
                            icon: './assets/icons/water-drop-icon.svg',
                            textColor: '#ffffff',
                            iconColor: '#ffffff',
                            text: 'Add water',
                            onPress: () {
                              Navigator.of(context).pushNamed('/add',
                                  arguments: AddBillArguments(
                                      widget.user, BillType.water));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 220,
                          width: 160,
                          child: QuickActionCard(
                            color: '#E2A576',
                            icon: './assets/icons/water-drop-icon.svg',
                            textColor: '#ffffff',
                            iconColor: '#ffffff',
                            text: 'Add water',
                            onPress: () {
                              Navigator.of(context).pushNamed('/add',
                                  arguments: AddBillArguments(
                                      widget.user, BillType.water));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Latest Transactions',
                    style: eTitleText,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#E2A576'),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  child: BillsStreamBuilder(
                    user: widget.user,
                    isLatest: true,
                    isSeparated: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
