import 'package:flutter/material.dart';
import 'package:easy_utilities/constants.dart' as Constants;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50.0)),
            Container(
              child: Text(
                'Easily Track Your Utility Spend.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.purple[10],
                  fontSize: 24.0,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/add', arguments: Constants.ELECTRICITY);
                        },
                        color: Colors.blue,
                        textColor: Colors.deepOrange[50],
                        child: Icon(
                          Icons.power,
                          size: 40,
                        ),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text('Add Electricity bill'),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/add', arguments: Constants.WATER);
                        },
                        color: Colors.blue,
                        textColor: Colors.deepOrange[50],
                        child: Icon(
                          Icons.water_damage,
                          size: 40,
                        ),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text('Add Water bill'),
                    ],
                  ),
                ]),
            SizedBox(
              height: 80,
            ),
            Text(
              'R 1200.00',
              style: TextStyle(
                fontSize: 30.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'OVERALL SPEND',
              style: TextStyle(fontSize: 15.0, letterSpacing: 1.0),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white70,
          backgroundColor: Color.fromRGBO(192, 63, 138, 60),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Add Utility',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.data_usage_outlined,
              ),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
