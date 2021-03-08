import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/widgets/latest_transaction_card.dart';
import 'package:easy_utilities/widgets/quick_action_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
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
                        'Good evening,\nCryptic Gxdly',
                        style: eBlackHeading,
                      ),
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            AssetImage('./assets/images/profile-img.jpg'),
                        backgroundColor: Colors.white,
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
                  Text(
                    'Quick Actions',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Roboto'),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 280,
                          width: 160,
                          child: QuickActionCard(
                            color: '#F664F7',
                            icon: './assets/icons/electricity-icon.svg',
                            text: 'Add electricity',
                            textColor: '#F6EEE0',
                            iconColor: '#F6EEE0',
                            onPress: () => {print('clicked')},
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 280,
                          width: 160,
                          child: QuickActionCard(
                            color: '#DA7423',
                            icon: './assets/icons/water-drop-icon.svg',
                            textColor: '#ffffff',
                            iconColor: '#ffffff',
                            text: 'Add water',
                            onPress: () => {print('clicked')},
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 280,
                          width: 160,
                          child: QuickActionCard(
                            color: '#2389DA',
                            icon: './assets/icons/water-drop-icon.svg',
                            textColor: '#ffffff',
                            iconColor: '#ffffff',
                            text: 'Add water',
                            onPress: () => {print('clicked')},
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 280,
                          width: 160,
                          child: QuickActionCard(
                            color: '#E2A576',
                            icon: './assets/icons/water-drop-icon.svg',
                            textColor: '#ffffff',
                            iconColor: '#ffffff',
                            text: 'Add water',
                            onPress: () => {print('clicked')},
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
            Row(
              children: <Widget>[Text('Latest Transactions')],
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    LatestTransactionCard(),
                    LatestTransactionCard(),
                    LatestTransactionCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
