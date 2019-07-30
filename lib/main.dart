import 'package:flutter/material.dart';
import 'package:flutter_trip/page/home_page.dart';
import 'package:flutter_trip/page/my_page.dart';
import 'package:flutter_trip/page/search_page.dart';
import 'package:flutter_trip/page/travel_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter之旅',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PageController _controller = PageController(initialPage: 0);

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true,),
          TravelPage(),
          MyPage()
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              _controller.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomItem('首页', Icons.home, 0),
              _bottomItem('搜索', Icons.search, 1),
              _bottomItem('旅拍', Icons.camera_alt, 2),
              _bottomItem('我的', Icons.account_circle, 3),
            ]),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}
