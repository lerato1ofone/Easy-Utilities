import 'package:easy_utilities/core/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {

  String emailOrPhonenumber = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
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
                            ),
                            PasswordInput(
                              icon: FontAwesomeIcons.lock,
                              hint: 'Password',
                              inputAction: TextInputAction.done,
                              onChanged: (value) => onPasswordChange(value),
                            ),
                            PasswordInput(
                              icon: FontAwesomeIcons.lock,
                              hint: 'Confirm Password',
                              inputAction: TextInputAction.done,
                              onChanged: (value) => onConfirmPasswordChange(value),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            RoundedButton(text: 'Register',   onButtonPressed: () => _register(),),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.white, width: 1),
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
                              onButtonPressed: () =>  Navigator.of(context).pushNamed('/login'),
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
      ],
    );
  }

  void onEmailChange(value) {
    setState(() {
      emailOrPhonenumber = value;
    });
  }

  void onPasswordChange(value){
    setState(() {
      password = value;
    });
  }

  void onConfirmPasswordChange(value){
    setState(() {
      confirmPassword = value;
    });
  }

  void _register() {
    print('email: $emailOrPhonenumber');
    print('password: $password');
    print('password: $confirmPassword');
  }
}
