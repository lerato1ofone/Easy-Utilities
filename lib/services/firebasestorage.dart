import 'package:easy_utilities/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStoreService extends ChangeNotifier {
  FireStoreService({this.user});

  final UserData user;

  static Future<dynamic> loadImage(BuildContext context, UserData user) async {
    return await FirebaseStorage.instance
        .ref()
        .child('profileImages/${user.uid}')
        .getDownloadURL();
  }
}
