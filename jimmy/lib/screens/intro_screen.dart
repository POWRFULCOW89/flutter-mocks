import 'package:flutter/material.dart';
import 'package:jimmy/shared/menu_drawer.dart';
import 'package:jimmy/shared/bottom_navigation.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MenuDrawer(),
        appBar: AppBar(title: const Text("Jimmy")),
        bottomNavigationBar: const BottomNavigation(),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/background.jpg'))),
            child: Center(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: const Text('Hello World',
                        style: TextStyle(fontSize: 18, shadows: [
                          Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3.0,
                              color: Colors.grey)
                        ]))))));
  }
}
