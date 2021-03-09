import 'package:easy_utilities/data/bill_type.dart';

class Bill {
  final String uid;

  Bill({this.uid});
}

class BillData {
  final String uid;
  final double amount;
  final DateTime date;
  final BillType type;
  final double kwh;
  final double litres;
  final String userId;

  BillData(
      {this.uid,
      this.amount,
      this.date,
      this.type,
      this.kwh,
      this.litres,
      this.userId});
}
