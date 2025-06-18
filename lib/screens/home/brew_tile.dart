import 'package:flutter/material.dart';
import 'package:my_tea_ghar/models/brew.dart';


class BrewTile extends StatelessWidget {
  
  final Brew brew;
  const BrewTile({super.key, required this.brew});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:10),
      child:Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius:25 ,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      )
    );
  }
}
