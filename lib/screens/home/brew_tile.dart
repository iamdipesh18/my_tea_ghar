import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tea_ghar/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown[50],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.brown[brew.strength],
            child: ClipOval(
              child: Image.asset(
                'assets/images/coffee_icon.png',
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            brew.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.brown[800],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              'Sugar Cubes: ${brew.sugars}',
              style: TextStyle(color: Colors.brown[400], fontSize: 14),
            ),
          ),
          trailing: SizedBox(
            width: 50,
            height: 50,
            child: Lottie.asset(
              'assets/lottie/coffeesplash.json',
              repeat: true,
              animate: true,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
