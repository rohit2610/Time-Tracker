import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/activity.dart';

class StopWatch extends StatefulWidget {
  //StopWatch({Key key}) : super(key: key);
  var _addActivity;
  StopWatch(this._addActivity);

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  var swatch = Stopwatch();
  String time = "00:00:00";
  bool isStop = true;
  bool isStart = true;
  bool isReset = true;

  Duration parseString(String s) {
    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    List<String> parts = s.split(":");
    hours = int.parse(parts[0]);
    minutes = int.parse(parts[1]);
    seconds = int.parse(parts[2]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  int timeInSeconds(String s) {
    List<String> parts = s.split(":");
    int hours = int.parse(parts[0] * 60 * 60);
    int minutes = int.parse(parts[1] * 60);
    int seconds = int.parse(parts[2]);

    return (hours + minutes + seconds);
  }

  void startTimer() {
    Timer(Duration(seconds: 1), keepRunning);
  }

  void keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      time = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startStopWatch() {
    swatch.start();
    startTimer();

    setState(() {
      isStart = false;
      isReset = false;
    });
  }

  void stopStopWatch() {
    swatch.stop();
    setState(() {
      isStop = false;
      isStart = true;
    });

    String startTime = DateFormat('HH:mm:ss')
        .format(DateTime.now().subtract(parseString(time)))
        .toString();
    //print(startTime);
    String endTime = DateFormat('HH:mm:ss').format(DateTime.now());
    //print(endTime);
    //int timeInSeconds = DateTime.now().subtract(duration)
    int timeSeconds = timeInSeconds(time);
    Activity at = Activity(
        id: DateTime.now().toString(),
        startTime: startTime,
        endTime: endTime,
        date: DateTime.now(),
        timeInSeconds: timeSeconds);

    widget._addActivity(at);
  }

  void resetStopWatch() {
    swatch.reset();

    setState(() {
      time = "00:00:00";
      isReset = true;
      isStop = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              //alignment: Alignment.center,
              child: Text(
                time,
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      onPressed: isStart ? null : stopStopWatch,
                      child: Text("Stop"),
                    ),
                    RaisedButton(
                      color: Colors.orange,
                      onPressed: isStop ? null : resetStopWatch,
                      child: Text("Reset"),
                    )
                  ],
                ),
                RaisedButton(
                  color: Colors.green,
                  onPressed: isReset ? startStopWatch : null,
                  child: Text("Start"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
