import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/body.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

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
      body: Body(user: widget.user),
    );
  }
}
