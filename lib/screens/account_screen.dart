import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/screens/account/components/body.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Account',
          style: ePageHeading,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Body(),
    );
  }
}
