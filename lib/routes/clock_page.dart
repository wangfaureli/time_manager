import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Clock extends StatefulWidget {
  Clock({Key key}) : super(key: key);

  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clock"),),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(formatDate(_selectedDateTime,
                    [yyyy, " - ", mm, " - ", dd, "  ", HH, " : ", nn])),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('counte time widget'),
              )
            ],
          )
        ],
      ),
    );
  }
}
