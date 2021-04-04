enum BillType { water, electricity }

extension ParseToString on BillType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
