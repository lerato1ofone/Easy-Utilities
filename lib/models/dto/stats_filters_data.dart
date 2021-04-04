import 'package:easy_utilities/data/bill_type.dart';

class StatsFiltersData {
  final List<String> names;
  final List<BillType> billTypes;
  final double minPrice;
  final double maxPrice;
  final DateTime endDate;
  final DateTime startDate;

  StatsFiltersData(this.names, this.billTypes, this.minPrice, this.maxPrice,
      this.startDate, this.endDate);
}
