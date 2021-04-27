import 'package:flutter/material.dart';
import 'package:nuru/user_interface/screens/Authentication/login_screen.dart';
import 'package:nuru/user_interface/screens/Authentication/register_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignInScreen = true;

  void toggleView() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showSignInScreen) {
      return LoginScreen(toggleView);
    } else {
      return RegisterScreen(toggleView);
    }
  }
}