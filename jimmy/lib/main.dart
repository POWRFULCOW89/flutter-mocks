import 'package:flutter/material.dart';
import 'package:jimmy/screens/intro_screen.dart';
import 'package:jimmy/screens/bmi_screen.dart';

import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(const JimmyApp());
}

class JimmyApp extends StatelessWidget {
  const JimmyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: const IntroScreen(),
        title: "Jimmy App",
        routes: {
          // '/': (context) => IntroScreen(),
          '/bmi': (context) => const BMIScreen(),
        });
  }
}
