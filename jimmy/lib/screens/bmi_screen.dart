import 'package:flutter/material.dart';
import 'package:jimmy/shared/bottom_navigation.dart';
import 'package:jimmy/shared/menu_drawer.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  List<bool> isSelected = [true, false];

  double _height = 0;
  double _weight = 0;

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _heightController.addListener(() {
      setState(() {
        try {
          _height = double.parse(_heightController.text);
        } catch (e) {
          print(e);
        }
      });
    });

    _weightController.addListener(() {
      setState(() {
        try {
          _weight = double.parse(_weightController.text);
        } catch (e) {
          print(e);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('BMI Calculator')),
        drawer: MenuDrawer(),
        bottomNavigationBar: BottomNavigation(),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ToggleButtons(
              children: const [Option("Metric"), Option("Imperial")],
              isSelected: isSelected,
              onPressed: (int index) {
                // print(index);
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    if (index != i) isSelected[i] = false;
                  }

                  isSelected[index] = !isSelected[index];
                  // print(isSelected);
                });
              },
            ),
            Container(
                padding: EdgeInsetsDirectional.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text("Height in " + (isSelected[0] ? "meters" : "inches"),
                        style: TextStyle(fontSize: 20)),
                    TextField(
                      controller: _heightController,
                      // onChanged: () {
                      //   setState(() {
                      //     _height = double.parse(_heightController.text);
                      //   });
                      // },
                    ),
                    SizedBox(height: 20),
                    Text(
                        "Weight in " + (isSelected[0] ? "kilograms" : "pounds"),
                        style: TextStyle(fontSize: 20)),
                    TextField(
                      controller: _weightController,
                      // onChanged: () {
                      //   setState(() {
                      //     _weight = double.parse(_weightController.text);
                      //   });
                      // },
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  _heightController.clear();
                  _weightController.clear();
                  showDialog(
                      context: context,
                      builder: (context) {
                        double result = 0;

                        if (isSelected[0]) {
                          result = _weight / (_height * _height);
                        } else if (isSelected[1]) {
                          double _heightInInches = _height / 39.37;
                          double _weightInPounds = _weight / 2.2046;
                          result = (_weightInPounds /
                              (_heightInInches * _heightInInches));
                        }
                        print(result);

                        return Dialog(
                            child: Container(
                                padding: EdgeInsets.all(100),
                                child: Text(
                                  'Your BMI is ${result.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )));
                      });
                  // AlertDialog(
                  //     title:
                  //         Text('Your BMI is ${_weight / (_height * _height)}'));
                },
                child: Text('Calculate'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                ))
          ]),
        ));
  }
}

class Option extends StatelessWidget {
  final String text;
  const Option(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Text(text, style: TextStyle(fontSize: 18)));
  }
}

class Field extends StatelessWidget {
  TextEditingController controller;
  Field({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(30),
        child: TextField(
            controller: controller,
            onEditingComplete: () {
              controller.text;
              controller.clear();
            }));
  }
}
