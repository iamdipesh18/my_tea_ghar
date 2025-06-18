import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_tea_ghar/models/brew.dart';
import 'package:my_tea_ghar/models/user.dart';

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

  //user data from sanpshot
  /*
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserData(
      uid: uid,
      name: data['name'] ?? '',
      sugars: data['sugars'] ?? '0',
      strength: data['strength'] ?? 0,
    );
  }
  */
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    if (!snapshot.exists || snapshot.data() == null) {
      return UserData(uid: uid, name: '', sugars: '0', strength: 100);
    }

    final data = snapshot.data()! as Map<String, dynamic>;

    // Ensure strength is int, parse if string
    int strengthValue = 100;
    if (data['strength'] is int) {
      strengthValue = data['strength'];
    } else if (data['strength'] is String) {
      strengthValue = int.tryParse(data['strength']) ?? 100;
    }

    return UserData(
      uid: uid,
      name: data['name'] ?? '',
      sugars: data['sugars'] ?? '0',
      strength: data['strength'] ?? 0,
    );
  }

  // Get Brews Stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
