import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
    this.imageFile,
    this.image,
    this.press,
  }) : super(key: key);

  final File imageFile;
  final String image;
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
              : CircleAvatar(
                  backgroundImage: AssetImage(image),
                  backgroundColor: Colors.white,
                ),
          Positioned(
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
        ],
      ),
    );
  }
}
