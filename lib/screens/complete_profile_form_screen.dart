import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:easy_utilities/services/database.dart';
import 'package:easy_utilities/widgets/error_message.dart';
import 'package:easy_utilities/widgets/rounded_button.dart';
import 'package:easy_utilities/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompleteProfileFormScreen extends StatefulWidget {
  const CompleteProfileFormScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  _CompleteProfileFormScreenState createState() =>
      _CompleteProfileFormScreenState();
}

class _CompleteProfileFormScreenState extends State<CompleteProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';

  String profilePhotoUrl = '';

  String error = '';

  final bool showToast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Complete your profile',
            style: ePageHeading,
          ),
          elevation: 0.0,
          backgroundColor: Colors.white),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          './assets/images/complete-profile-background.png'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.darken))),
            ),
            Container(
              color: Colors.transparent,
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              ProfilePicture(
                                image:
                                    './assets/images/default-profile-img.jpg',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextInput(
                                icon: FontAwesomeIcons.user,
                                hint: 'Enter your name ',
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                                onChanged: (value) => _onNameChange(value),
                                validator: (value) =>
                                    value.isEmpty ? 'Enter a name' : null,
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
                                text: 'Update Profile',
                                color: Colors.blue,
                                onButtonPressed: () => _updateProfile(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNameChange(value) {
    setState(() {
      name = value;
    });
  }

  void _updateProfile() async {
    if (_formKey.currentState.validate()) {
      dynamic result = DatabaseService(uid: widget.user.uid).updateUserData(
          name,
          widget.user.emailOrPhonenumber,
          widget.user.password,
          profilePhotoUrl,
          true);

      if (result == null) {
        setState(() {
          error = 'Please enter a name';
        });
      } else {
        Navigator.of(context).pushNamed('/landing', arguments: widget.user);
      }
    }
  }
}
