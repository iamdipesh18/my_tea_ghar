import 'package:flutter/material.dart';
import 'package:my_tea_ghar/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized(); // Required before Firebase init
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Wrapper());
  }
}
