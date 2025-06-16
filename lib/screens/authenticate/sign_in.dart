import 'package:flutter/material.dart';
import 'package:my_tea_ghar/services/auth.dart';

class SignIn extends StatefulWidget {
  
  final Function toggleView;
  const SignIn({super.key, required this.toggleView}); // ✅ Named parameter

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to My Tea Ghar',
              style: TextStyle(
              color: Colors.white,
              fontSize: 20.0, // Optional: you can set font size here
              fontWeight: FontWeight.bold, // Optional: bold text
              ),
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton.icon(
            icon:Icon(Icons.person),
            onPressed: (){
              widget.toggleView();

            },
            label:Text('Register',
                   style: TextStyle(
              color: Colors.black,
              fontSize: 20.0, // Optional: you can set font size here
              fontWeight: FontWeight.bold, // Optional: bold text
              ),
              ),
          )
        ],
      ),
      /*
      //For Anonymous Sign In
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null) {
              print("Error Signing In");
            } else {
              print("Siged In");
              print(result.uid);
            }
          },
          child: Text('Sign In Anonymously'),
        ),
      ),
      //For Anonymous Sign In 
      */
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(height: 20),
              //for password
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.pink[400]),
                onPressed: () async {
                  print(email);
                  print(password);
                },
                child: Text('Log In', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
