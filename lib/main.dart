import 'package:easy_utilities/models/user.dart';
import 'package:easy_utilities/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
          initialData: null,
          child: MaterialApp(
          home: Wrapper(),
      ),
    );
  }
}