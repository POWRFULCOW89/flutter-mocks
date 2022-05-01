import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        // Navigator.of(context).pop();

        switch (index) {
          case 0:
            Navigator.of(context).pushNamed('/');
            break;
          case 1:
            Navigator.of(context).pushNamed('/bmi');
            break;
          default:
            Navigator.of(context).pushNamed('/');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "BMI Calculator",
          activeIcon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
