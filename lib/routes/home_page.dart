import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class TimePickerPage extends StatefulWidget {
  TimePickerPage({Key key}) : super(key: key);

  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {

    /// Display time picker.
    void _showStartDateTimePicker() {
      DatePicker.showDatePicker(
        context,
        minDateTime: DateTime.parse("2019-05-15 09:23:10"),
        maxDateTime: DateTime.parse("2020-06-03 21:11:00"),
        initialDateTime: DateTime.parse(formatDate(_selectedDateTime, [yyyy, "-", mm, "-", "dd", " ", HH, ":", nn, ":", ss])),
        dateFormat: "yy-MM-dd    HH:mm",
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
            _selectedDateTime = dateTime;
          });
        },
        onConfirm: (dateTime, List<int> index) {
          setState(() {
            _selectedDateTime = dateTime;
          });
        },
      );
    }

    void _showEndDateTimePicker() {
      DatePicker.showDatePicker(
        context,
        minDateTime: DateTime.parse("2019-05-15 09:23:10"),
        maxDateTime: DateTime.parse("2020-06-03 21:11:00"),
        initialDateTime: DateTime.parse(formatDate(_selectedDateTime, [yyyy, "-", mm, "-", "dd", " ", HH, ":", nn, ":", ss])),
        dateFormat: "yy-MM-dd    HH:mm",
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
            _selectedDateTime = dateTime;
          });
        },
        onConfirm: (dateTime, List<int> index) {
          setState(() {
            _selectedDateTime = dateTime;
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
                    Text(formatDate(_selectedDateTime,
                        [yyyy, "-", mm, "-", dd, " ", HH, ":", nn])),
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
                    Text(formatDate(_selectedDateTime,
                        [yyyy, "-", mm, "-", dd, " ", HH, ":", nn])),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}



