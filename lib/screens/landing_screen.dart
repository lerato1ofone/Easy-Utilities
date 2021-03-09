import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/complete_profile.dart';
import 'package:flutter/material.dart';
import 'package:easy_utilities/screens/account_screen.dart';
import 'package:easy_utilities/screens/home_screen.dart';
import 'package:easy_utilities/screens/bills_screen.dart';
import 'package:easy_utilities/screens/stats_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({
    Key key,
    this.user,
  }) : super(key: key);

  final UserData user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();

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
    if (widget.user != null && widget.user.profileUpdated != true) {
      return CompleteProfileScreen(
        user: widget.user,
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              HomeScreen(
                user: widget.user,
              ),
              BillsScreen(),
              StatsScreen(),
              AccountScreen(),
            ],
            onPageChanged: _onPageChanged,
          ),
        ),
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedLabelStyle: TextStyle(color: Colors.indigo[100]),
            selectedItemColor: Colors.indigo[100],
            backgroundColor: Colors.white,
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
}
