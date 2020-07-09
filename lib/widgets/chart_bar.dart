import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  //const ChartBar({Key key}) : super(key: key);
  final String day;
  final double percentage;
  final String time;

  ChartBar(
      {@required this.day, @required this.percentage, @required this.time});

  @override
  Widget build(BuildContext context) {
    print(time);
    return Column(
      children: <Widget>[
        FittedBox(
          fit: BoxFit.fill,
          child: Text(time),
        ),
        SizedBox(height: 10),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: 1 - percentage,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(day),
      ],
    );
  }
}
