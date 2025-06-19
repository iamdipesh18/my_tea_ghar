import 'package:flutter/material.dart';
import 'package:my_tea_ghar/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_tea_ghar/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:my_tea_ghar/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authService = AuthService();

  runApp(
    StreamProvider<MyUser?>.value(
      value: authService.user,
      initialData: null,
      child: MyApp(authService: authService),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
