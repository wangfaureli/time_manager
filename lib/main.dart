import 'package:time_manager/routes/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
//  SharedPreferences.setMockInitialValues({});
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Time Manager',

      theme: new ThemeData(
        primaryColor: new Color.fromARGB(0xff, 0x1a, 0xb7, 0x6e),
      ),
      home: HomePage(),
    );
  }
}