import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/landing_screen.dart';
import 'package:easy_utilities/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return LandingScreen(
                user: userData,
              );
            } else {
              return Container(
                child: Text('Loading...'),
              );
            }
          });
    }
  }
}
