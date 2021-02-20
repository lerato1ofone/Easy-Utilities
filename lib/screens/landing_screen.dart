import 'package:flutter/material.dart';
import 'package:easy_utilities/screens/account_screen.dart';
import 'package:easy_utilities/screens/home_screen.dart';
import 'package:easy_utilities/screens/bills_screen.dart';
import 'package:easy_utilities/screens/stats_screen.dart';
import 'package:easy_utilities/core/hex_color.dart';

class LandingScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();

  List<Widget> _screens = [
    HomeScreen(),
    BillsScreen(),
    StatsScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int selectIndex) {
    _pageController.animateToPage(selectIndex,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedLabelStyle: TextStyle(color: Colors.indigo[100]),
          selectedItemColor:Colors.indigo[100],
          backgroundColor: HexColor.fromHex('#4A4040'),
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Add Utility',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.data_usage_outlined),
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
