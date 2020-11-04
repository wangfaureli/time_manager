import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:time_manager/api/workingTimeApi.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_manager/model/Post.dart';
import 'package:time_manager/model/User.dart';
import 'dart:convert';

class WorkingTime extends StatefulWidget {
  @override
  _WorkingTimeState createState() => new _WorkingTimeState();
}

class _WorkingTimeState extends State<WorkingTime> {
  User _user;
  List<Post> _posts = [];
  DateTime _currentItemDateStart;
  DateTime _currentItemDateEnd;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentItemDateStart = DateTime.parse("2019-05-15 09:23:10");
      _currentItemDateEnd = DateTime.parse("2020-06-03 21:11:00");
    });
    getSharedPrefs();
    getPosts();
//    updatePost();
  }

  Future getPosts() async {
    var response = await WorkingTimeApi.getUserWorkingTimes(1);
    print(response.body);
    var posts = List<Post>.from(jsonDecode(response.body).map((p) => Post.fromJson(p)));
    setState(() {
      _posts = posts;
    });
  }

  void deleteWorkingTime(int workingTimeId) async {
    var response = await WorkingTimeApi.deleteWorkingTime(workingTimeId);
    if (response.statusCode == 200) {
      setState(() {
        _posts.removeWhere((p) => p.id == workingTimeId);
      });
    }
    else
      print("Error while deleting working time");
  }

//  void _updateWorkingTimePressed (int workingTimeId) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    User user = User.fromJson(jsonDecode(prefs.getString('userJson')));
//    print(user.username);
//    var response = await WorkingTimeApi.updateWorkingTime(user.id, workingTimeId, _startDate, _endDate);
//    print(response.body);
//  }

  void updatePost(int workingTimeId, DateTime start, DateTime end) async {
    var response = await WorkingTimeApi.updateWorkingTime(_user.id, workingTimeId, start, end);
    if (response.statusCode == 200) {
      setState(() {
        var index = _posts.indexWhere((p) => p.id == workingTimeId);
        Post post = new Post(id: _user.id, title: start.toString(), body: end.toString());
        setState(() {
          _posts[index] = post;
        });
      });
    }
    else
      print("Error while deleting working time");
  }
//

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user = User.fromJson(jsonDecode(prefs.getString('userJson')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Working Times")),
      body: new Container(
        padding: EdgeInsets.fromLTRB(10,10,10,0),
//        height: 220,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: _posts != null ? _posts.length : 0,
          itemBuilder: (context, index) {
            return new Container(
              child: _workingTimeCard(_posts[index])
            );
          }
        ),
      ),
    );
  }

  Widget _workingTimeCard(Post post) {
    return new Container(
      child: Column(children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Start Time', textAlign: TextAlign.center),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(post.title, textAlign: TextAlign.center),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('End Time', textAlign: TextAlign.center),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(post.id.toString(), textAlign: TextAlign.center),
                  ),
                ],
              ),
              Row(
                children: <Widget>[_buttonGroup(post.id),],
              ),
            ],
          ),
        ),
      ]),
    );
  }
  
  Widget _buttonGroup(int workingTimeId) {
    return new Container(
      child: Expanded(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: new RaisedButton(
                child: new Text('Edit'),
                onPressed: () {
                  _updateDialog(workingTimeId);
                }
              ),
            ),
            new RaisedButton(
              child: new Text('Delete'),
                onPressed: () => deleteWorkingTime(workingTimeId)),
          ],
        ),
      ),
    );
  }

  _updateDialog(int workingTimeId) {
    showDialog(
      context: context,
      builder: (_) =>
          new AlertDialog(
            title: new Text("Edit Working Time"),
            content: new Container(
              child: new _Timer(
                workingTimeId: workingTimeId,
                userId: _user.id,
                startDate: _currentItemDateStart,
                endDate: _currentItemDateEnd,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )
    );
  }
}

class _Timer extends StatefulWidget {
  _Timer({Key key, @required this.workingTimeId, @required this.startDate, @required this.endDate, @required this.userId}) : super(key: key);

  final int workingTimeId;
  final int userId;
  final DateTime startDate;
  final DateTime endDate;

  _TimerState createState() => _TimerState();
}

class _TimerState extends State<_Timer> {

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    /// Display time picker.
    void _showStartDateTimePicker() {
      DatePicker.showDatePicker(
        context,
        minDateTime: DateTime.parse("2019-05-15 09:23:10"),
        maxDateTime: DateTime.parse("2020-06-03 21:11:00"),
        initialDateTime: DateTime.parse(formatDate(_startDate, [yyyy, "-", mm, "-", "dd", " ", HH, ":", nn, ":", ss])),
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
            _startDate = dateTime;
          });
        },
        onConfirm: (dateTime, List<int> index) {
          setState(() {
            _startDate = dateTime;
          });
        },
      );
    }

    void _showEndDateTimePicker() {
      DatePicker.showDatePicker(
        context,
        minDateTime: DateTime.parse("2019-05-15 09:23:10"),
        maxDateTime: DateTime.parse("2020-06-03 21:11:00"),
        initialDateTime: DateTime.parse(formatDate(_endDate, [yyyy, "-", mm, "-", "dd", " ", HH, ":", nn, ":", ss])),
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
            _endDate = dateTime;
          });
        },
        onConfirm: (dateTime, List<int> index) {
          setState(() {
            _endDate = dateTime;
          });
        },
      );
    }

    return Scaffold(
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
                    Text(formatDate(_startDate,
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
                    Text(formatDate(_endDate,
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
                onPressed: () => updatePost(widget.workingTimeId, widget.userId),
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

  void updatePost(int workingTimeId, int userId) async {
    var response = await WorkingTimeApi.updateWorkingTime(userId, workingTimeId, _startDate, _endDate);
    if (response.statusCode == 200) {
      print("Error while deleting working time");
//      setState(() {
//        var index = _posts.indexWhere((p) => p.id == workingTimeId);
//        Post post = new Post(id: _user.id, title: start.toString(), body: end.toString());
//        setState(() {
//          _posts[index] = post;
//        });
//      });
    }
    else
      print("Error while deleting working time");
  }
}