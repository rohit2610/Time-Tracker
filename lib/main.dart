import 'package:flutter/material.dart';
import 'package:time_tracker/models/activity.dart';
import 'package:time_tracker/widgets/activity_list.dart';
import 'package:time_tracker/widgets/chart.dart';
import 'package:time_tracker/sql_database/sqlprovider.dart';
import 'package:time_tracker/widgets/stopwatch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void getDatabase() async {
    final db = await SQLProvider.db.database;
    print(db.path);
    List<Activity> list = await SQLProvider.db.getAllActivity();
    setState(() {
      _activityList.addAll(list);
    });
  }

  final List<Activity> _activityList = [];

  void _addActivity(Activity at) {
    setState(() {
      print(at);
      var result = SQLProvider.db.insert(at);
      _activityList.insert(0, at);
      //print(result);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabase();
  }

  @override
  Widget build(BuildContext context) {
    // getDatabase();

    final appBar = AppBar(
      title: Text("Time Tracker"),
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: <Widget>[
                Flexible(flex: 2, child: Chart(_activityList)),
                Flexible(flex: 2, child: StopWatch(_addActivity)),
                Flexible(flex: 4, child: ActivityList(_activityList)),
              ],
            ),
          ),
        ));
  }
}
