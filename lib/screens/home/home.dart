import 'package:flutter/material.dart';
import 'package:my_tea_ghar/models/brew.dart';
import 'package:my_tea_ghar/services/auth.dart';
import 'package:my_tea_ghar/services/database.dart';
import 'package:provider/provider.dart';
import 'package:my_tea_ghar/screens/home/brew_list.dart';
import 'package:my_tea_ghar/models/user.dart'; // You need to import your MyUser model

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsetsGeometry.symmetric(
              vertical: 20,
              horizontal: 60,
            ),
            child: Text('bottom sheet'),
          );
        },
      );
    }

    if (user == null) {
      return Center(child: CircularProgressIndicator());
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: user.uid).brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('My Tea Ghar', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.black),
              label: Text('Log Out', style: TextStyle(color: Colors.black)),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.settings, color: Colors.black),
              label: Text('settings', style: TextStyle(color: Colors.black)),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
