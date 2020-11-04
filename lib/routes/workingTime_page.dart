import 'package:flutter/material.dart';
import 'package:time_manager/api/workingTimeApi.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_manager/model/Post.dart';
import 'package:time_manager/model/User.dart';
import 'dart:convert';

//class WorkingTime extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(color: const Color(0xFF6D2D3A));
//  }
//}

class WorkingTime extends StatefulWidget {
  @override
  _WorkingTimeState createState() => new _WorkingTimeState();
}

class _WorkingTimeState extends State<WorkingTime> {
  User _user;
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    getPosts();
  }

  Future getPosts() async {
    print("coucou");
    var response = await WorkingTimeApi.getUserWorkingTimes(1);
    print(response.body);
    var posts = List<Post>.from(jsonDecode(response.body).map((p) => Post.fromJson(p)));
    setState(() {
      print(posts);
      _posts = posts;
    });
  }

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
                children: <Widget>[_buttonGroup()],
              ),
            ],
          ),
        ),
      ]),
    );
  }
  
  Widget _buttonGroup() {
    return new Container(
      child: Expanded(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: new RaisedButton(
                child: new Text('Edit'),
                onPressed: null),
            ),
            new RaisedButton(
              child: new Text('Delete'),
                onPressed: null),
          ],
        ),
      ),
    );
  }


}
