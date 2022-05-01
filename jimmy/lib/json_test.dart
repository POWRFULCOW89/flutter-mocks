import 'package:flutter/material.dart';
import 'package:jimmy/screens/intro_screen.dart';
import 'package:jimmy/screens/bmi_screen.dart';

import 'package:http/http.dart';
import 'dart:convert';

class JimmyApp extends StatelessWidget {
  const JimmyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //     theme: ThemeData(primarySwatch: Colors.red),
    //     home: IntroScreen(),
    //     routes: {
    //       // '/': (context) => IntroScreen(),
    //       '/bmi': (context) => BMIScreen(),
    //     });

    return MaterialApp(
        title: 'SWAPI',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('SWAPI'),
          ),
          body: FutureBuilder<List<dynamic>>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: ((context, index) => ListTile(
                          title: Text(snapshot.data[index]['name']),
                          leading: Text("${index + 1}"),
                          onTap: () {},
                          subtitle: Text(
                              "Height: ${snapshot.data[index]['height']} | Mass: ${snapshot.data[index]['mass']}"),
                        )),
                  );
                } else {
                  return const Text("Error");
                }
              }),
        ));
  }
}

Future<List<dynamic>> getData() async {
  final Response response =
      await get(Uri.parse('https://swapi.dev/api/people/'));

  print(response);
  dynamic data = json.decode(response.body);
  List<dynamic> results = data['results'];

  return results;
  // return .map((item) => Character.fromJson(item));
}

class Character {
  final int name;
  final int height;
  final int mass;
  final String birth_year;

  const Character({
    required this.name,
    required this.height,
    required this.mass,
    required this.birth_year,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] as int,
      height: json['height'] as int,
      mass: json['mass'] as int,
      birth_year: json['birth_year'] as String,
    );
  }
}
