import 'package:flutter/material.dart';
import 'package:jimmy/data/session.dart';
import 'package:jimmy/data/sp_helper.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final TextEditingController _dateController =
      TextEditingController(text: DateTime.now().toString());

  final TextEditingController _descriptionController = TextEditingController();

  int duration = 1;

  final SPHelper spHelper = SPHelper();
  List<Session> sessions = [];
  @override
  void initState() {
    super.initState();
    spHelper.init().then(
      (value) {
        renderSessions();
      },
    );
  }

  renderSessions() {
    spHelper.readSessions().then((value) {
      setState(() {
        sessions = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training'),
      ),
      body: Center(
          child: Container(child: ListView(children: getSessionTiles()))),
      floatingActionButton: FloatingActionButton(
        tooltip: "New training",
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.blue, width: 3)),
        onPressed: () {
          showSessionDialog(context);
        },
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("New training"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _dateController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      label: Text('Date'),
                      hintText: "When did you start?",
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        label: Text('Description'),
                        hintText: "What did we accomplish"),
                  ),
                  DropdownButton(
                    items: makeDropdownOptions(),
                    onChanged: (dynamic selection) {
                      // print(selection);
                      setState(() {
                        duration = selection;
                      });
                    },
                    value: duration,
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: saveSession, child: const Text("Save")),
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _dateController.clear();
                      _descriptionController.clear();
                      duration = 1;
                    },
                    child: const Text('Cancel')),
              ]);
        });
  }

  void saveSession() {
    print("Saving session");
    // spHelper.
    Session newSession = Session(spHelper.getSessionCount() + 1,
        _dateController.text, _descriptionController.text, duration);
    spHelper.writeSession(newSession);
    Navigator.pop(context);
    _dateController.clear();
    _descriptionController.clear();
    duration = 1;
    renderSessions();
  }

  List<DropdownMenuItem<dynamic>> makeDropdownOptions() {
    return [
      for (int i = 1; i <= 10; i++)
        DropdownMenuItem(child: Text("$i"), value: i)
    ];
  }

  List<Widget> getSessionTiles() {
    return [
      for (Session session in sessions)
        Dismissible(
          key: Key(session.id.toString()),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.startToEnd) {
              spHelper.deleteSession(session.id);
              renderSessions();
            } else {}
          },
          child: ListTile(
              title: Text(session.date),
              subtitle: Text(session.description),
              trailing: Text(session.duration.toString())),
        )
    ];
  }
}
