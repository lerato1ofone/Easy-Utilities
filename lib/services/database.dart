import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_utilities/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference billsCollection =
      Firestore.instance.collection('accounts');

  Future updateUserData(String name, String emailOrPhoneNumber, String password,
      String profilePhotoUrl, bool profileUpdated) async {
    return await billsCollection.document(uid).setData({
      'name': name,
      'emailOrPhoneNumber': emailOrPhoneNumber,
      'password': password,
      'profilePhotoUrl': profilePhotoUrl,
      'profileUpdated': profileUpdated
    });
  }

  Future<bool> getUserProfileUpdateStatus() async {
    await billsCollection.document(uid).get().then((doc) {
      return doc.data['profileUpdated'];
    });
    return true;
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        emailOrPhonenumber: snapshot.data['emailOrPhoneNumber'],
        profilePhotoUrl: snapshot.data['profilePhotoUrl'],
        profileUpdated: snapshot.data['profileUpdated']);
  }

  // Get user document
  Stream<UserData> get userData {
    return billsCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
