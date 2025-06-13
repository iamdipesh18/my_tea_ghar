import 'package:flutter/material.dart';
import 'package:my_tea_ghar/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // We need to return either Home or Authentication Widget
    // This screen is like a point from where if user is authenticated then will go to home else go to authenticate

    return Authenticate();
  }
}
