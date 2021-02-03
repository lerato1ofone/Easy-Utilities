import 'package:flutter/material.dart';

class AddBillScreen extends StatefulWidget {
  // This value is passed into this widget to determine which bill to add (Electricity or Water bill)
  final String bill;

  AddBillScreen({
    Key key,
    @required this.bill,
  }) : super(key: key);

  @override
  _AddBillScreenState createState() => _AddBillScreenState(bill);
}

class _AddBillScreenState extends State<AddBillScreen> {
  String bill;

  //constructor
  _AddBillScreenState(this. bill);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a utility'),
      ),
        body: Center(
      child: Text('bill : $bill'),
    ));
  }
}
