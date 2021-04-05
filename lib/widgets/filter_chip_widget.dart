import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';

typedef IntCallback = Function(String val, bool isAdd);

class FilterChipWidget extends StatefulWidget {
  FilterChipWidget({
    Key key,
    @required this.returnFilterValue,
    @required this.chipName,
    @required this.isRenderingFilters,
    this.isSmall = false,
    this.isShowCloseIcon,
    this.chipColor,
  }) : super(key: key);

  final String chipName;
  final IntCallback returnFilterValue;
  final bool isSmall;
  final bool isShowCloseIcon;
  final bool isRenderingFilters;
  final Color chipColor;

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var isSelected = false;
  @override
  Widget build(BuildContext context) {
    if (widget.isRenderingFilters) {
      return FilterChip(
        padding: EdgeInsets.symmetric(horizontal: 5),
        label: Text(widget.chipName),
        labelStyle: widget.isSmall ? eSmallText : eBodyText1,
        selected: isSelected,
        backgroundColor: widget.chipColor ?? HexColor.fromHex('#fff'),
        onSelected: (_isSelected) {
          setState(() {
            isSelected = _isSelected;
          });
          widget.returnFilterValue(widget.chipName, isSelected);
        },
        selectedColor: Colors.greenAccent,
        showCheckmark: false,
        avatar: CircleAvatar(
          radius: 10,
          child: Icon(
            Icons.close,
            size: 15,
          ),
        ),
      );
    }
    return FilterChip(
      padding: EdgeInsets.symmetric(horizontal: 5),
      label: Text(widget.chipName),
      labelStyle: widget.isSmall ? eSmallText : eBodyText1,
      selected: isSelected,
      backgroundColor: widget.chipColor ?? HexColor.fromHex('#fff'),
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
