import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/activity.dart';
import 'package:time_tracker/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  // Chart({Key key}) : super(key: key);
  final List<Activity> _recentTransaction;

  String convertSecondsintoString(int time) {
    Duration duration = Duration(seconds: time);
    //print(time);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitsinMintes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitsinSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitsinMintes:$twoDigitsinSeconds";
  }

  List<Map<String, Object>> get transactionValue {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        int totalTimeInSeconds = 0;
        for (int i = 0; i < _recentTransaction.length; i++) {
          if (_recentTransaction[i].date.day == weekDay.day &&
              _recentTransaction[i].date.month == weekDay.month &&
              _recentTransaction[i].date.year == weekDay.year) {
            totalTimeInSeconds += _recentTransaction[i].timeInSeconds;
          }
        }

        //String t = "1" ; //convertSecondsintoString(totalTimeInSeconds);
        //double percentage = totalTime == 0.0 ? print(a) : (totalTimeInSeconds/totalTime);
        //print(totalTime);

        return {
          //'timeInSeconds' : totalTimeInSeconds ,
          'day': DateFormat.E().format(weekDay),
          'time': totalTimeInSeconds,
          //'percentage' : 1.0 ,
        };
      },
    );
  }

  //final var _transactionValue = transactionValue ;

  double get totalTime {
    return transactionValue.fold(0.0, (sum, act) {
      //print(act['timeInSeconds']);
      return sum + act['time'];
    });
  }

  Chart(this._recentTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.25,
      child: Card(
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: transactionValue.map((data) {
            return ChartBar(
              day: data['day'],
              percentage:
                  totalTime == 0 ? 0 : ((data['time'] as int) / totalTime),
              time: convertSecondsintoString(data['time']),
            );
          }).toList(),
        ),
      ),
    );
  }
}
