import 'package:flutter/material.dart';

class BillsScreen extends StatefulWidget {
  // This value is passed into this widget to determine which bill to add (Electricity or Water bill)
  final String bill;

  BillsScreen({
    Key key,
    @required this.bill,
  }) : super(key: key);

  @override
  _BillsScreenState createState() => _BillsScreenState(bill);
}

class _BillsScreenState extends State<BillsScreen> {
  String bill;
  
  //constructor
  _BillsScreenState(this. bill);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a utility'),
      ),
        body: Center(
      child: Text('Bills Screen'),
    ));
  }
}
