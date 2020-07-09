import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Activity {
  String id;
  String startTime;
  String endTime;
  DateTime date;
  int timeInSeconds;

  Activity(
      {@required this.id,
      @required this.startTime,
      @required this.endTime,
      @required this.date,
      @required this.timeInSeconds});

  factory Activity.fromMap(Map<String, dynamic> data) {
    //print(DateTime.parse(data['date']));
    return Activity(
      id: data['id'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      date: (DateTime.parse(data['date'])),
      timeInSeconds: data['timeInSeconds'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "startTime": startTime,
        "endTime": endTime,
        "date": date.toString(),
        "timeInSeconds": timeInSeconds
      };
}
