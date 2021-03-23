import 'dart:io';
import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/services/firebasestorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
    @required this.disableIcon,
    @required this.user,
    this.press,
    this.imageFile,
  }) : super(key: key);

  final File imageFile;
  final UserData user;
  final bool disableIcon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          imageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    imageFile,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : FutureBuilder(
                  future: _getImage(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data;
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ),
          !disableIcon
              ? Positioned(
                  right: -10,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      color: Color(0XFFF5F6F9),
                      onPressed: () {
                        press();
                      },
                      child: SvgPicture.asset(
                        './assets/icons/camera-icon.svg',
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context) async {
    Image image;
    await FireStoreService.loadImage(context, user).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.cover,
      );
    });
    return ClipRRect(
      borderRadius: BorderRadius.circular(80.0),
      child: image,
    );
  }
}
