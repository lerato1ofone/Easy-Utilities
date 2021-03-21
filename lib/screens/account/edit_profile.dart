import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:easy_utilities/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key key,
    @required this.user,
    this.scaffoldContext,
  }) : super(key: key);

  final UserData user;
  final BuildContext scaffoldContext;
  final double topWidgetHeight = 200.0;
  final double avatarRadius = 50.0;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: HexColor.fromHex('#afeeee'),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Container(
                      height: widget.topWidgetHeight,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('#afeeee'),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextInput(
                              icon: FontAwesomeIcons.user,
                              hint: widget.user.name,
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              onChanged: (value) => _onNameChange(value),
                              validator: (value) =>
                                  value.isEmpty ? 'Enter a name' : null,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextInput(
                              icon: FontAwesomeIcons.solidEnvelope,
                              hint: widget.user.emailOrPhonenumber,
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              onChanged: (value) => _onNameChange(value),
                              validator: (value) =>
                                  value.isEmpty ? 'Enter a name' : null,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            // ignore: deprecated_member_use
                            FlatButton(
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: HexColor.fromHex('#E4E0FA'),
                              onPressed: () {
                                print('updating your profile');
                              },
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Update profile',
                                    style: TextStyle(
                                        fontSize: 18.5,
                                        color: HexColor.fromHex('#2D4343'),
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: new Container(
                      child: Text(
                        'Edit your profile',
                        style: eBlackHeading,
                      ),
                    ),
                  ),
                ),
                new Positioned(
                  child: ProfilePicture(
                    image: widget.user.profilePhotoUrl,
                  ),
                  left: (MediaQuery.of(context).size.width / 2) -
                      widget.avatarRadius,
                  top: widget.topWidgetHeight - widget.avatarRadius,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onNameChange(value) {
    setState(() {
      name = value;
    });
  }
}
