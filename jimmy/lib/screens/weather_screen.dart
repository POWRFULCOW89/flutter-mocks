import 'package:flutter/material.dart';
import 'package:jimmy/shared/menu_drawer.dart';

import 'package:http/http.dart';
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<dynamic, dynamic> initialWeatherData = {
    "place": "here",
    "description": "clear",
    "temperature": 0,
  };

  late Map<dynamic, dynamic> weatherData = initialWeatherData;

  final TextEditingController _cityController = TextEditingController();

  Future _weatherFuture(String city) async {
    try {
      String apiKey = "";
      String url =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";

      Response response = await get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e);
      setState(() {
        weatherData = {"Error": e.toString()};
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _cityController.addListener(() {
  //     setState(() {
  //       weatherData =
  //           _weatherFuture(_cityController.text) as Map<dynamic, dynamic>;
  //     });
  //   });
  // }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),
        drawer: MenuDrawer(),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                        hintText: "Type in a city...",
                        suffixIcon: Icon(Icons.search)),
                    onSubmitted: (String city) {
                      _weatherFuture(city);
                    }),
                SizedBox(height: 30),
                Flexible(child: Properties(weatherData))
              ],
            )));
  }
}

class Properties extends StatelessWidget {
  final Map<dynamic, dynamic> weatherData;
  const Properties(this.weatherData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List parsedData = weatherData.entries.toList();

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          String title = parsedData[index].key;
          String capitalized =
              title.replaceFirst(title[0], title[0].toUpperCase());
          return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(children: [
                Expanded(child: Text(capitalized)),
                Expanded(child: Text(parsedData[index].value.toString()))
              ]));
          // ListTile(

          //     title: Text(capitalized),
          //     trailing: Text(parsedData[index].value.toString(),
          //         style: TextStyle(color: Theme.of(context).primaryColor)));
        },
        itemCount: weatherData.entries.length);
  }
}

// build a widget after fetching data from an endpoint
// build a future widget
