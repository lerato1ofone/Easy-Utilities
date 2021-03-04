import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text field state
  final _formKey = GlobalKey<FormState>();

  String emailOrPhoneNumber = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                                validator: (value) =>
                                value.isEmpty ? 'Enter an email or phone number' : null,
                              ),
                              PasswordInput(
                                validator: (value) =>
                                value.length < 6 ? 'Enter a password 6+ chars long' : null,
                                icon: FontAwesomeIcons.lock,
                                hint: 'Password',
                                inputAction: TextInputAction.done,
                                onChanged: (value) => onPasswordChange(value),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  'Forgot Password?',
                                  style: eBodyText,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              RoundedButton(
                                text: 'Login',
                                onButtonPressed: () => _login(),
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
                                  "Don't have an account?",
                                  style: eBodyText,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              SmallRoundedButton(
                                text: 'Sign Up',
                                onButtonPressed: () =>  Navigator.of(context).pushNamed('/register'),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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

  void onPasswordChange(value){
    setState(() {
      password = value;
    });
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      print('email: $emailOrPhoneNumber');
      print('password: $password');
    }
  }
}
