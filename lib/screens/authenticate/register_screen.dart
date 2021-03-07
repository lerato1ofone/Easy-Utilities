import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/services/auth.dart';
import 'package:easy_utilities/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key, this.toggleView}) : super(key: key);

  final VoidCallback toggleView;
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  String emailOrPhoneNumber = '';
  String password = '';
  String confirmPassword = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(image: './assets/images/login.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: Center(
                      child: Text('Easy Utilities', style: eHeading),
                    ),
                  ),
                  SizedBox(
                    height: 31,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              TextInput(
                                icon: FontAwesomeIcons.solidEnvelope,
                                hint: 'Email or Phone number',
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                                onChanged: (value) => onEmailChange(value),
                                validator: (value) => value.isEmpty
                                    ? 'Enter an email or phone number'
                                    : null,
                              ),
                              PasswordInput(
                                validator: (value) => value.length < 6
                                    ? 'Enter a password 6+ chars long'
                                    : null,
                                icon: FontAwesomeIcons.lock,
                                hint: 'Password',
                                inputAction: TextInputAction.done,
                                onChanged: (value) => onPasswordChange(value),
                              ),
                              PasswordInput(
                                validator: (value) => value != password
                                    ? 'Passwords do not match'
                                    : null,
                                icon: FontAwesomeIcons.lock,
                                hint: 'Confirm Password',
                                inputAction: TextInputAction.done,
                                onChanged: (value) =>
                                    onConfirmPasswordChange(value),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              ErrorMessage(text: error),
                              RoundedButton(
                                text: 'Register',
                                color: Colors.blue,
                                onButtonPressed: () => _register(),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                ),
                                child: Text(
                                  "Have an account already?",
                                  style: eBodyText,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              SmallRoundedButton(
                                text: 'Sign In',
                                onButtonPressed: () => widget.toggleView(),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onEmailChange(value) {
    setState(() {
      emailOrPhoneNumber = value;
    });
  }

  void onPasswordChange(value) {
    setState(() {
      password = value;
    });
  }

  void onConfirmPasswordChange(value) {
    setState(() {
      confirmPassword = value;
    });
  }

  void _register() async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _auth.registerWithEmailOrPhoneNumberAndPassword(
          emailOrPhoneNumber, password);
      if (result == null) {
        setState(() {
          error = 'Please supply a valid email';
        });
      }
    }
  }
}
