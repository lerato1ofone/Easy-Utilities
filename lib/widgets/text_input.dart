import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key key,
        @required this.icon,
        @required this.hint,
        @required this.inputType,
        @required this.inputAction})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: eBodyText,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          style: eBodyText,
          keyboardType: inputType,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}