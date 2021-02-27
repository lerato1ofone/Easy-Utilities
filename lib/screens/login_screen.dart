import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Image(
              image: AssetImage('./assets/images/login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ]),
      );
  }
}
