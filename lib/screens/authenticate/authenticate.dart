import 'package:flutter/material.dart';
import 'package:my_tea_ghar/screens/authenticate/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: SignIn(),
    );
  }
}