import 'package:easy_utilities/models/bill.dart';
import 'package:easy_utilities/models/user.dart';

class BarChartData {
  final UserData user;
  final List<BillData> bills;
  final double totalBillsAmount;
  final double totalElectricityBillsAmount;
  final double totalWaterBillsAmount;

  BarChartData(this.user, this.bills, this.totalBillsAmount,
      this.totalElectricityBillsAmount, this.totalWaterBillsAmount);
}
