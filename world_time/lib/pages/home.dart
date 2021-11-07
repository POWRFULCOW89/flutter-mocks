import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    // data = ModalRoute.of(context)!.settings.arguments as Map;

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color fontColor = data['isDayTime'] ? Colors.black : Colors.white;

    print(data['time']);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
            // fit
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              children: [
                FlatButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location, color: fontColor),
                    label: Text('Edit location',
                        style: TextStyle(color: fontColor))),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data['location'],
                        style: TextStyle(
                            color: fontColor, fontSize: 28, letterSpacing: 1.5))
                  ],
                ),
                const SizedBox(height: 25),
                Text(data['time'],
                    style: TextStyle(fontSize: 60, color: fontColor)),
                // Text(data['isDayTime'].toString())
              ],
            ),
          ),
        )));
  }
}
