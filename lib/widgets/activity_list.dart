import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/models/activity.dart';

class ActivityList extends StatelessWidget {
  //const ActivityList({Key key}) : super(key: key);
  final List<Activity> _activityList;
  ActivityList(this._activityList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.5,
      child: ListView.builder(
        itemCount: _activityList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Text("Start Time ${_activityList[index].startTime}"),
                Text("End Time ${_activityList[index].endTime}"),
                Text(DateFormat("yyyy-MM-dd").format(_activityList[index].date))
              ],
            ),
          );
        },
      ),
    );
  }
}
