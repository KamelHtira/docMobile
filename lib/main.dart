// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:learning_app/login_page.dart';
import 'package:learning_app/route_generator.dart';

void main() => runApp(MyApp());

MaterialColor primaryColor = MaterialColor(
  0xFF00846c,
  <int, Color>{
    50: Color(0xFFE1E9F5),
    100: Color(0xFFB4C6E7),
    200: Color(0xFF82A9D8),
    300: Color(0xFF4F8CC9),
    400: Color(0xFF2B6CB9),
    500: Color(0xFF0957A0),
    600: Color(0xFF084F8A),
    700: Color(0xFF074772),
    800: Color(0xFF063E5A),
    900: Color(0xFF042C36),
  },
);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFF00846c),
    minimumSize: Size(50, 40),
    padding: EdgeInsets.symmetric(horizontal: 16),
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(10)),
    // ),
    elevation: 0);

const InputDecorationTheme kInputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),

  labelStyle: TextStyle(
    fontSize: 14,
  ),
  // enabledBorder: OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(10)),
  //   borderSide: BorderSide.none,
  // ),
  filled: true,
  fillColor: Color.fromARGB(255, 249, 249, 249),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: 14,
          ),
        ),
        primarySwatch: primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: raisedButtonStyle,
          // Set height for all ElevatedButton widgets
        ),
        inputDecorationTheme: kInputDecorationTheme,
      ),
      home: LoginPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
