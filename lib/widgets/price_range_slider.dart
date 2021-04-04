import 'package:flutter/material.dart';

typedef IntCallback = Function(RangeValues num);

class PriceRangeSlider extends StatefulWidget {
  PriceRangeSlider({
    Key key,
    @required this.press,
  }) : super(key: key);

  final IntCallback press;

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _currentRangeValues = const RangeValues(0, 500);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RangeSlider(
        values: _currentRangeValues,
        min: 0,
        max: 500,
        divisions: 10,
        labels: RangeLabels(
          _currentRangeValues.start.round().toString(),
          _currentRangeValues.end.round().toString(),
        ),
        onChangeEnd: (values) => widget.press(_currentRangeValues),
        onChanged: (RangeValues values) {
          setState(() {
            _currentRangeValues = values;
          });
        },
      ),
    );
  }
}
