import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference billsCollection =
      Firestore.instance.collection('accounts');

  Future updateUserData(String name, String emailOrPhoneNumber, String password,
      String photoUrl) async {
    return await billsCollection.document(uid).setData({
      'name': name,
      'emailOrPhoneNumber': emailOrPhoneNumber,
      'password': password,
      'photoUrl': photoUrl
    });
  }
}
