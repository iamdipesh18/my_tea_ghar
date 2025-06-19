import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_tea_ghar/models/brew.dart';
import 'package:my_tea_ghar/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    //print(brews.docs);

    if (brews == null) {
      return Center(child: CircularProgressIndicator());
    }
//     for (var brew in brews) {
// // print(brew.name);
// // print(brew.sugars);
// // print(brew.strength);
//     }
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
