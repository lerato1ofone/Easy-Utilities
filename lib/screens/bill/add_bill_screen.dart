import 'package:easy_utilities/models/user.dart';
import 'package:flutter/material.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;
  @override
  _AddBillScreenState createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
