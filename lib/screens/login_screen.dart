import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 150.0,
                  child: Center(
                    child: Text('Easy Utilities', style: eHeading),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16.0)
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: eBodyText,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                              child: Icon(
                                FontAwesomeIcons.envelope, color: Colors.white,
                                  size: 30.0,
                              ),
                            ),
                          ),
                          style: eBodyText,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
