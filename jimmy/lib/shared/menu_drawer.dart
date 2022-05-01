import 'package:flutter/material.dart';
import '../screens/bmi_screen.dart';
import '../screens/intro_screen.dart';
import '../screens/training_screen.dart';
import '../screens/weather_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(children: buildMenuItems(context)));
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> titles = [
      'Home',
      'BMI Calculator',
      'Weather',
      'Training'
    ];

    final List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
        decoration: BoxDecoration(color: Colors.grey),
        child: Text('Jimmy', style: const TextStyle(fontSize: 28))));

    for (var element in titles) {
      Widget screen;
      menuItems.add(ListTile(
        title: Text(element, style: const TextStyle(fontSize: 20)),
        onTap: () {
          switch (element.toLowerCase()) {
            case 'home':
              screen = const IntroScreen();
              break;
            case 'bmi calculator':
              screen = const BMIScreen();
              break;
            case 'weather':
              screen = const WeatherScreen();
              break;
            case 'training':
              screen = const TrainingScreen();
              break;
            default:
              screen = const IntroScreen();
          }

          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => screen));
        },
      ));
    }

    return menuItems;
  }
}
