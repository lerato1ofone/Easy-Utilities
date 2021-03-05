import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Bill {
  Bill({this.amount, this.date, this.type, this.kwh, this.by});

  final double amount;
  final DateTime date;
  final String type;
  final double kwh;
  final String by;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
      amount: json["amount"],
      date: json["date"],
      type: json["type"],
      kwh: json["kwh"],
      by: json["by"],
    );

  Map<String, dynamic> toJson() => {
    "amount": this.amount,
    "date": this.date,
    "type": this.type,
    "kwh": this.kwh,
    "by": this.by,
  };
}