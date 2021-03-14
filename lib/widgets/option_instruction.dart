import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';

class OptionInstruction extends StatelessWidget {
  const OptionInstruction({
    Key key,
    this.text,
    this.requiredNo,
  }) : super(key: key);

  final String text;
  final int requiredNo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: eQuestionText,
        ),
        Container(
          decoration: new BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${requiredNo.toString()} REQUIRED',
              style: eRequiredText,
            ),
          ),
        ),
      ],
    );
  }
}
