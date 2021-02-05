import 'package:flutter/material.dart';
import 'package:easy_utilities/screens/account_screen.dart';
import 'package:easy_utilities/screens/landing_screen.dart';
import 'package:easy_utilities/screens/add_bill.dart';
import 'package:easy_utilities/screens/stats_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();

  List<Widget> _screens = [
    LandingScreen(),
    BillsScreen(bill: null),
    StatsScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int selectIndex) {
    _pageController.jumpToPage(selectIndex);
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
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedLabelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
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
