import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return Authenticate();
    } else {
      return LandingScreen();
    }
  }
}