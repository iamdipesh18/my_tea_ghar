import 'package:flutter/material.dart';
import 'package:my_tea_ghar/models/user.dart';
import 'package:my_tea_ghar/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:my_tea_ghar/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
       print("User in Wrapper: ${user?.uid}"); // for debugging
    // We need to return either Home or Authentication Widget
    // This screen is like a point from where if user is authenticated then will go to home else go to authenticate
    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home(); // or your actual home screen
    }
  }
}
