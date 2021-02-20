// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) {
  return Bill(
    amount: (json['amount'] as num).toDouble(),
    date: DateTime.parse(json['date'] as String),
    type: _$enumDecode(_$BillTypeEnumMap, json['type']),
    kwh: (json['kwh'] as num).toDouble(),
    by: json['by'] as String,
  );
}

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'type': _$BillTypeEnumMap[instance.type],
      'kwh': instance.kwh,
      'by': instance.by,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$BillTypeEnumMap = {
  BillType.WATER: 'water',
  BillType.ELECTRICITY: 'electricity',
};
