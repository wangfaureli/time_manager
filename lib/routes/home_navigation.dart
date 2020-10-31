import 'package:flutter/material.dart';
import './home_page.dart';
import './workingTime_page.dart';
import './clock_page.dart';
import './login_page.dart';

class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Navigator(
      initialRoute: 'home_page',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'home_page':
            builder = (BuildContext context) => new TimePickerPage();
            break;
          case 'first_navigation':
//            builder = (BuildContext context) => new ImagesListScreen();
            break;
          default:
            throw new Exception('Invalid route: ${settings.name}');
        }

        return new MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TimePickerPage(),
    WorkingTime(),
    Clock(),
    Login(),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Time Manager'),
        centerTitle: true,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home")
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.list),
              title: new Text("Working Time")
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.timer),
              title : new Text('Clock')
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title : new Text('Login')
          ),
        ]
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


