import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage(
      {Key key,
        @required this.text})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    if(text == null){
      return null;
    } else{
      return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.red[100]),
          ),
        ),
      );
    }
  }
}
