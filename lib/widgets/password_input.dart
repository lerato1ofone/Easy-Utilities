import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput(
      {Key key,
      @required this.icon,
      @required this.hint,
      @required this.inputAction,
      @required this.onChanged})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputAction inputAction;
  final ValueChanged<String> onChanged;

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
          textInputAction: inputAction,
          obscureText: true,
          onChanged: (val) => onChanged(val),
        ),
      ),
    );
  }
}
