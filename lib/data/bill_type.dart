enum BillType { water, electricity, all }

extension ParseToString on BillType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
