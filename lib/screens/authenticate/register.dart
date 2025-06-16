import 'package:flutter/material.dart';
import 'package:my_tea_ghar/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView}); // ✅ Named parameter
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  //formkey is used as the flutter built in validation for entering valid credentials
  final _formkey = GlobalKey<FormState>();
  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text(
          'Sign Up to My Tea Ghar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0, // Optional: you can set font size here
            fontWeight: FontWeight.bold, // Optional: bold text
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            onPressed: () {
              widget.toggleView();
            },
            label: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0, // Optional: you can set font size here
                fontWeight: FontWeight.bold, // Optional: bold text
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter an email';
                  }
                  return null;
                },

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
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Enter a password 6+ Chars Long';
                  }
                  return null;
                },

                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.pink[400]),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    //print(email);
                    //print(password);
                    // TODO: Call _auth.registerWithEmailAndPassword(email, password)
                    dynamic result = await _auth.registerWithEmailAndPassword(
                      email,
                      password,
                    );
                    if (result == null) {
                      setState(() {
                        error = 'Please Enter Valid Credentials';
                      });
                    }
                  }
                },
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height:12,),
              Text('Error',style: TextStyle(color: Colors.red,fontSize: 14,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
