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
  //Form Variables
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;

          // Initialize form fields only once on first data load
          if (!_initialized) {
            _currentName = userData.name;
            _currentSugars = userData.sugars;
            _currentStrength = userData.strength;
            _initialized = true;
          }

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update Your Coffee Settings.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),

                // Name input
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
                      initialValue: _currentName,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'User Name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.brown[400],
                        ),
                      ),
                      validator:
                          (val) =>
                              (val == null || val.isEmpty)
                                  ? 'Please Enter a Name'
                                  : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Sugar preference dropdown
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
                    DropdownButtonFormField<String>(
                      decoration: textInputDecoration,
                      value: _currentSugars,
                      items:
                          sugars.map((sugar) {
                            return DropdownMenuItem<String>(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            );
                          }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Strength slider
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
                      value: (_currentStrength ?? 100).toDouble(),
                      activeColor:
                          Colors.brown[(_currentStrength != null &&
                                  _currentStrength! >= 100 &&
                                  _currentStrength! <= 900)
                              ? _currentStrength!
                              : 400],
                      inactiveColor:
                          Colors.brown[(_currentStrength != null &&
                                  _currentStrength! >= 100 &&
                                  _currentStrength! <= 900)
                              ? _currentStrength!
                              : 200],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      label: '${_currentStrength ?? 100}',
                      onChanged:
                          (val) =>
                              setState(() => _currentStrength = val.round()),
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

                SizedBox(height: 20),

                // Update button
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      Navigator.pop(context);
                    }
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
