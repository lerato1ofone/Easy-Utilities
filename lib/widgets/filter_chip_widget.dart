import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';

typedef IntCallback = Function(String val, bool isAdd);

class FilterChipWidget extends StatefulWidget {
  FilterChipWidget({
    Key key,
    @required this.returnFilterValue,
    @required this.chipName,
    this.isSmall = false,
    this.isShowCloseIcon,
  }) : super(key: key);

  final String chipName;
  final IntCallback returnFilterValue;
  final bool isSmall;
  final bool isShowCloseIcon;

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var isSelected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      padding: EdgeInsets.symmetric(horizontal: 5),
      label: Text(widget.chipName),
      labelStyle: widget.isSmall ? eSmallText : eBodyText1,
      selected: isSelected,
      backgroundColor: HexColor.fromHex('#fff'),
      onSelected: (_isSelected) {
        setState(() {
          isSelected = _isSelected;
        });
        widget.returnFilterValue(widget.chipName, isSelected);
      },
      selectedColor: Colors.greenAccent,
    );
  }
}
