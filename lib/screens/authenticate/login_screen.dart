import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/widgets.dart';
import 'package:easy_utilities/widgets/error_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key, this.toggleView}) : super(key: key);

  final VoidCallback toggleView;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();

  // text field state
  final _formKey = GlobalKey<FormState>();

  String emailOrPhoneNumber = '';
  String password = '';

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
                                height: 40,
                              ),
                              ErrorMessage(text: error),
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

  void onPasswordChange(value) {
    setState(() {
      password = value;
    });
  }

  void _login() async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _auth.signInWithEmailOrPhoneNumberAndPassword(
          emailOrPhoneNumber, password);
      if (result == null) {
        setState(() {
          error = 'Invalid credentials';
        });
      }
    }
  }
}
