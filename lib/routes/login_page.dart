import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:time_manager/api/userApi.dart';
import 'package:time_manager/model/User.dart';
import 'package:time_manager/model/Post.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginState();
}

enum FormType {
  login,
  register
}

class _LoginState extends State<Login> {

  final TextEditingController _userNameFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();

  String _userName = "";
  String _email = "";
  String _password = "";
  FormType _form = FormType.login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginState() {
    _userNameFilter.addListener(_userNameListen);
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _userNameListen() {
    if (_userNameFilter.text.isEmpty) {
      _userName = "";
    } else {
      _userName = _userNameFilter.text;
    }
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),

          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _userNameFilter,
              decoration: new InputDecoration(
                  labelText: 'User Name'
              ),
            ),
          ),
          (_form == FormType.register ? new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                  labelText: 'Email'
              ),
            ),
          ) : new Container()),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Login'),
              onPressed: _loginPressed,
            ),
            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.'),
              onPressed: _formChange,
            ),
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Create an Account'),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.'),
              onPressed: _formChange,
            ),
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed () async {
    print('The user wants to login with $_userName and $_email and $_password');
    var response = await UserApi.login(_userName, _password);
    String user = response.body;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userJson', user);
//    print(prefs.getString('userJson'));
  }

  void _createAccountPressed () async {
    print('The user wants to create an accoutn with $_userName and $_email and $_password');
    var response = await UserApi.createUser(_userName, _password, _email);
    print(response.body);
//    String user = response.body;
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('userJson', jsonEncode(user));
//    print(prefs.getString('userJson'));

    Post post = Post.fromJson(jsonDecode(response.body));
    print(post.title);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userJson', jsonEncode(post));
    post = Post.fromJson(jsonDecode(prefs.getString('userJson')));
    print(post.body);

//    User user = User.fromJson(jsonDecode(response.body));
//    print(user.username);
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('userJson', jsonEncode(user));
//    print(prefs.getString('userJson'));
  }

  Widget _userLogin() {
    if(this._userName.isEmpty) {
      return new Container(
        child: new Column(
          children: <Widget>[
            Expanded(
              child: Text('Welcome Time Manager', textAlign: TextAlign.center),
            ),
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            Expanded(
              child: Text('Your are connected', textAlign: TextAlign.center,),
            )
          ],
        ),
      );
    }
  }
}
