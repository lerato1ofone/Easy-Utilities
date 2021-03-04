import 'package:flutter/material.dart';
import 'package:easy_utilities/screens/account_screen.dart';
import 'package:easy_utilities/screens/home_screen.dart';
import 'package:easy_utilities/screens/landing_screen.dart';
import 'package:easy_utilities/screens/stats_screen.dart';
import 'package:easy_utilities/screens/bills_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in when calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/landing':
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/bills':
        return MaterialPageRoute(
            builder: (_) => BillsScreen());
      case '/stats':
        return MaterialPageRoute(builder: (_) => StatsScreen());
      case '/account':
        return MaterialPageRoute(builder: (_) => AccountScreen());
      default:
        return _errorRoute();
    }
  }

  // Error route for any invalid page routes
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
