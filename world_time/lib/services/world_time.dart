import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDayTime = false; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    Response res =
        await get(Uri.parse("https://worldtimeapi.org/api/timezone/$url"));
    Map data = jsonDecode(res.body);

    DateTime datetime = DateTime.parse(data['datetime']);

    isDayTime = datetime.hour > 6 && datetime.hour < 20;

    time = DateFormat.jm().format(DateTime.parse(data['datetime']));
    print('api new time: $time');
  }
}
