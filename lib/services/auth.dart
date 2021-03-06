import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // creates user object based on the FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in with email and password
  Future signInWithEmailOrPhoneNumberAndPassword(
      String emailOrPhoneNumber, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: emailOrPhoneNumber, password: password);

      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email or phone number and password
  Future registerWithEmailOrPhoneNumberAndPassword(
      String emailOrPhoneNumber, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: emailOrPhoneNumber, password: password);

      FirebaseUser user = result.user;

      // create a new document with the user's uid
      await DatabaseService(uid: user.uid).updateUserData(
          emailOrPhoneNumber, emailOrPhoneNumber, password, '', false);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // check if the user exists in the database
  Future<bool> checkUserProfile(User user) async {
    try {
      bool value =
          await DatabaseService(uid: user.uid).getUserProfileUpdateStatus();
      return value;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
