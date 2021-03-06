import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:time_manager/api/workingTimeApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_manager/model/User.dart';

class TimePickerPage extends StatefulWidget {
  TimePickerPage({Key key}) : super(key: key);

  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  DateTime _selectedStartDateTime = DateTime.now();
  DateTime _selectedEndDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {

    /// Display time picker.
    void _showStartDateTimePicker() {
      DatePicker.showDatePicker(
        context,
        minDateTime: DateTime.parse("2019-05-15 09:23:10"),
        maxDateTime: DateTime.parse("2020-06-03 21:11:00"),
        initialDateTime: DateTime.parse(formatDate(_selectedStartDateTime, [yyyy, "-", mm, "-", "dd", " ", HH, ":", nn, ":", ss])),
        dateFormat: "yyyy - MM - dd    HH : mm",
        locale: DateTimePickerLocale.en_us,
        pickerTheme: DateTimePickerTheme(
          showTitle: true,
        ),
        pickerMode: DateTimePickerMode.datetime, // show TimePicker
        onCancel: () {
          debugPrint('onCancel');
        },
        onChange: (dateTime, List<int> index) {
          setState(() {
            _selectedStartDateTime = dateTime;
          });
        },
        onConfirm: (dateTime, List<int> index) {
          setState(() {
            _selectedStartDateTime = dateTime;
          });
        },
      );
    }

    void _showEndDateTimePicker() {
      DatePicker.showDatePicker(
        context,
        minDateTime: DateTime.parse("2019-05-15 09:23:10"),
        maxDateTime: DateTime.parse("2020-06-03 21:11:00"),
        initialDateTime: DateTime.parse(formatDate(_selectedEndDateTime, [yyyy, "-", mm, "-", "dd", " ", HH, ":", nn, ":", ss])),
        dateFormat: "yyyy-MM-dd    HH:mm",
        locale: DateTimePickerLocale.fr,
        pickerTheme: DateTimePickerTheme(
          showTitle: true,
        ),
        pickerMode: DateTimePickerMode.datetime, // show TimePicker
        onCancel: () {
          debugPrint('onCancel');
        },
        onChange: (dateTime, List<int> index) {
          setState(() {
            _selectedEndDateTime = dateTime;
          });
        },
        onConfirm: (dateTime, List<int> index) {
          setState(() {
            _selectedEndDateTime = dateTime;
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Working Time")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Start Time', textAlign: TextAlign.center),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _showStartDateTimePicker();
                },
                child: Row(
                  children: <Widget>[
                    Text(formatDate(_selectedStartDateTime,
                        [yyyy, " - ", mm, " - ", dd, " ", HH, ":", nn])),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('End Time', textAlign: TextAlign.center),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _showEndDateTimePicker();
                },
                child: Row(
                  children: <Widget>[
                    Text(formatDate(_selectedEndDateTime,
                        [yyyy, " - ", mm, " - ", dd, " ", HH, ":", nn])),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: new Color.fromARGB(0xff, 0x1a, 0xb7, 0x6e),
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: _createWorkingTimePressed,
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _createWorkingTimePressed () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(prefs.getString('userJson')));
    print(user.username);
    var response = await WorkingTimeApi.createWorkingTime(user.id, _selectedStartDateTime, _selectedEndDateTime);
    print(response.body);
  }
}



