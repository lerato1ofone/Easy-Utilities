import 'package:easy_utilities/data/bill_type.dart';
import 'package:easy_utilities/models/user.dart';

class AddBillArguments {
  final UserData user;
  final BillType billType;

  AddBillArguments(this.user, this.billType);
}
