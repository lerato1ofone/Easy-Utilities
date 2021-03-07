class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String password;
  final String emailOrPhonenumber;
  final String profilePhotoUrl;
  final bool profileUpdated;

  UserData(
      {this.uid,
      this.name,
      this.password,
      this.emailOrPhonenumber,
      this.profilePhotoUrl,
      this.profileUpdated});
}
