import 'package:easy_utilities/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // creates user object based on the FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // register with email or phone number and password
  Future registerWithEmailOrPhoneNumberAndPassword(
      String emailOrPhoneNumber, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: emailOrPhoneNumber, password: password);

      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
