import 'dart:io';
import 'package:easy_utilities/core/hex_color.dart';
import 'package:easy_utilities/core/palette.dart';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/account/components/profile_picture.dart';
import 'package:easy_utilities/services/database.dart';
import 'package:easy_utilities/widgets/text_input.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  String email = '';
  File _image;

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
              children: <Widget>[
                SingleChildScrollView(
                  child: new Column(
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
                                    value.isEmpty ? 'Enter an email' : null,
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
                                  _updateProfile();
                                },
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    user: widget.user,
                    imageFile: _image,
                    disableIcon: false,
                    press: () => chooseFile(),
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

  void onEmailChange(value) {
    setState(() {
      email = value;
    });
  }

  void _onNameChange(value) {
    setState(() {
      name = value;
    });
  }

  void _updateProfile() async {
    if (_image != null) uploadFile();

    dynamic result = DatabaseService(uid: widget.user.uid).updateUserData(
        name == "" ? widget.user.name : name,
        email == "" ? widget.user.emailOrPhonenumber : email,
        widget.user.password,
        true);

    if (result == null) {
      createSnackBar('Please supply valid information', Colors.red);
    } else {
      createSnackBar('Profile updated successfully!', Colors.green);
    }
  }

  void createSnackBar(String message, Color color) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: color);

    // ignore: deprecated_member_use
    Scaffold.of(widget.scaffoldContext).showSnackBar(snackBar);
  }

  Future chooseFile() async {
    final _picker = ImagePicker();

    await _picker.getImage(source: ImageSource.gallery).then((image) {
      if (_image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profileImages/${widget.user.uid}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
  }
}
