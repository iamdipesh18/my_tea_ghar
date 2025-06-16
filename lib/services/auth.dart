import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_tea_ghar/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //we need method to register

  //we need to create a method to sign in with both email and anonymous methods

  //Creating user object based upon the firebase User
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(user.uid) : null;
  }


  //Auth Change User Stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future<MyUser?> signInAnon() async {
    try {
      firebase_auth.UserCredential result = await _auth.signInAnonymously();
      firebase_auth.User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error signing in anonymously: $e');
      return null;
    }
  }

  //sign in with email

  //we also need sign out method
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return (null);
    }
  }
}
