import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tea_ghar/models/brew.dart';
import 'package:my_tea_ghar/models/user.dart';
import 'package:my_tea_ghar/screens/home/brew_list.dart';
import 'package:my_tea_ghar/screens/home/settings_form.dart';
import 'package:my_tea_ghar/services/auth.dart';
import 'package:my_tea_ghar/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  void _showSettingsPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF5E9DD),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: SettingsForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: user.uid).brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.brown.withOpacity(0.95),
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  /*
                  child: Lottie.asset(
                    'assets/images/coffeesplash.json',
                    fit: BoxFit.contain,
                    repeat: true,
                    animate: true,
                  ),
                  */
                  child: Image.asset(
                    'assets/images/tea.png', // replace with your image file name
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'My Tea Ghar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () async => await _auth.signOut(),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
          child: FloatingActionButton.extended(
            onPressed: () => _showSettingsPanel(context),
            backgroundColor: Colors.brown[400],
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              'Customize',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
          ),
        ),

        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: BrewList(),
            ),
          ),
        ),
      ),
    );
  }
}
