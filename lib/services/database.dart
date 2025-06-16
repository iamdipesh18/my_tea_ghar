import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_tea_ghar/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // Collection Reference
  final CollectionReference brewCollection = FirebaseFirestore.instance
      .collection('Brews');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

// Convert snapshot to list of Brew
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    // Make sure to use `doc.data()` and cast as Map
    final data = doc.data() as Map<String, dynamic>;
    return Brew(
      name: data['name'] ?? '',
      strength: data['strength'] ?? 0,
      sugars: data['sugars'] ?? '0',
    );
  }).toList();
}

// Get Brews Stream
Stream<List<Brew>> get brews {
  return brewCollection.snapshots().map(_brewListFromSnapshot);
}

}
