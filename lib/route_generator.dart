import 'package:flutter/material.dart';
import 'package:easy_utilities/screens/add_bill.dart';
import 'package:easy_utilities/screens/home.dart';
import 'package:easy_utilities/constants.dart' as Constants;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in when calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/add':
        if (args is String && args == Constants.ELECTRICITY || args == Constants.WATER) {
          return MaterialPageRoute(
              builder: (_) => AddBillScreen(bill: args)
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  // Error route for any invalid page routes
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder:
            (_) {
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