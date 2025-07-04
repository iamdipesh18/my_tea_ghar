import 'package:flutter/material.dart';
import 'package:my_tea_ghar/screens/authenticate/register.dart';
import 'package:my_tea_ghar/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(toggleView:toggleView);
    } else {
      return Register(toggleView:toggleView);
    }
  }
}
