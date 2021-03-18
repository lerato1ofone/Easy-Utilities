import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key key,
    @required this.icon,
    @required this.hint,
    @required this.inputType,
    @required this.inputAction,
    @required this.onChanged,
    this.iconColor,
    this.validator,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final Color iconColor;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final ValueChanged<String> onChanged;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: TextFormField(
          validator: (value) => validator(value),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: eBodyText,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: 30.0,
              ),
            ),
          ),
          style: eBodyText,
          keyboardType: inputType,
          textInputAction: inputAction,
          onChanged: (val) => onChanged(val),
        ),
      ),
    );
  }
}
