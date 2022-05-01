import 'package:shared_preferences/shared_preferences.dart';
import 'session.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeSession(Session session) async {
    prefs.setString(session.id.toString(), json.encode(session.toJson()));
  }

  Future<List<Session>> readSessions() async {
    Set<String> keys = prefs.getKeys();
    List<Session> sessions = [];
    for (String key in keys) {
      String? data = prefs.getString(key);
      if (data != null) {
        Session session = Session.fromJson(json.decode(data));
        sessions.add(session);
      }
    }

    return sessions;
  }

  Future deleteSession(int id) async {
    await prefs.remove(id.toString());
  }

  int getSessionCount() {
    return prefs.getKeys().length;
  }
}
