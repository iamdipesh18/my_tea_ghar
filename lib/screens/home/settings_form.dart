import 'package:flutter/material.dart';
import 'package:my_tea_ghar/services/database.dart';
import 'package:my_tea_ghar/shared/constants.dart';
import 'package:my_tea_ghar/models/user.dart';
import 'package:my_tea_ghar/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          UserData userData = asyncSnapshot.data!;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update Your Coffee Settings.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                /*
              TextFormField(
                decoration: textInputDecoration,
                validator:
                    (val) => (val?.isEmpty ?? true) ? 'Please Enter a Name' : null,
        
                onChanged: (val) => setState(() => _currentName = val),
              ),
              */
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'User Name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.brown[400],
                        ),
                      ),
                      validator:
                          (val) =>
                              (val?.isEmpty ?? true)
                                  ? 'Please Enter a Name'
                                  : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                //dropdown
                /*
              DropdownButtonFormField(
                decoration: textInputDecoration,
                value: _currentSugars ?? '0',
                items:
                    sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                onChanged: (val) => setState(() => _currentSugars = val),
              ),
              */
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sugar Preference',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ?? userData.sugars,
                      items:
                          sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            );
                          }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                  ],
                ),

                //slider
                /*
              Slider(
                value: (_currentStrength??100).toDouble(),
                activeColor: Colors.brown[_currentStrength??100],
                inactiveColor: Colors.brown[_currentStrength??100],
                min:100.0,
                max:900.0,
                divisions:8,
                onChanged: (value) => setState(()=>_currentStrength=  value.round()),
                ),
                */
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Coffee Strength',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    Slider(
                      value:
                          ((_currentStrength ?? userData.strength) as int)
                              .toDouble(),
                      activeColor:
                          Colors.brown[(_currentStrength ?? userData.strength)
                              as int],
                      inactiveColor:
                          Colors.brown[(_currentStrength ?? userData.strength)
                              as int],

                      min: 100.0,
                      max: 1000.0,
                      divisions: 8,
                      onChanged:
                          (value) =>
                              setState(() => _currentStrength = value.round()),
                    ),
                    Text(
                      'Strength Level: ${_currentStrength ?? 100}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown[300],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),

                //update button
                SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    print(_currentName);
                    print(_currentSugars);
                    print(_currentStrength);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    backgroundColor: Colors.brown[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
