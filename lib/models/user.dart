import 'package:easy_utilities/models/bill.dart';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String emailOrPhonenumber;
  final List<Bill> bills;

  UserData({this.uid, this.name, this.emailOrPhonenumber, this.bills});
}
