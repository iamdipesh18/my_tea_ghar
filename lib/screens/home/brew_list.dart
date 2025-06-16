import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<QuerySnapshot?>(context);

    //print(brews.docs);

     if (brews == null) {
    return Center(child: CircularProgressIndicator());
  }

  // proceed to build ListView from brews.docs...
      for (var doc in brews.docs) {
      print(doc.data());
    }
    return const Placeholder();
  }
}

