import 'package:flutter/material.dart';
import 'package:easy_utilities/constants.dart' as Constants;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login-img.jpg'),
            ),
          ),
        ),
        Scaffold(
          body: Container(),
        ),
      ],
    );
  }
}
