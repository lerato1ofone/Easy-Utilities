import 'package:flutter/material.dart';

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
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0)),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
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
              height: 120.0,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.blue,
                    textColor: Colors.deepOrange[50],
                    child: Icon(
                      Icons.power,
                      size: 40,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.blue,
                    textColor: Colors.deepOrange[50],
                    child: Icon(
                      Icons.water_damage,
                      size: 40,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                ]),
            SizedBox(
              height: 100,
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
              'Overall Spend',
              style: TextStyle(fontSize: 15.0, letterSpacing: 1.0),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(192, 63, 138, 50),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.addchart),
              label: 'Add Utility',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.data_usage_outlined,
              ),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
