import 'dart:math';

import 'package:easy_flutter/nettest/net_test.dart';
import 'package:easy_flutter/third_page.dart';
import 'package:easy_flutter/tab_controller.dart' as mycontroller;
import 'package:easy_flutter/wanandroid/chapter/wx_chapters.dart';
import 'package:easy_flutter/wanandroid/chapter/wx_chapters_history.dart';
import 'package:flutter/material.dart';

import 'animtest/animatedcontainer.dart';
import 'animtest/dragglecard.dart';
import 'map/map.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '这里是 App 的入口',
      home: MyFirstPage(),
      // 初始化路由列表，当推送路由的时候，则在 routes 中寻找路径名称，
      // 如果名称存在，则关联的 WidgetBuilder 构建 MaterialPageRoute
      routes: <String, WidgetBuilder>{
        '/myfirst': (BuildContext context) => MyFirstPage(),
//        '/mysecond': (BuildContext context) => animtest.AnimWidget(),
        '/mysecond': (BuildContext context) => DraggableCardDemo(),
//            mycontroller.MyCustomTabController(),

        '/mythird': (BuildContext context) => ScaffoldApp(),
        '/google_map': (BuildContext context) => MyMap(),
        '/nettest': (BuildContext context) => NetTest(),
        '/wxchapters': (BuildContext context) => WxChapters(),
        '/wx_chapters_history': (BuildContext context) => WxChapterHistories(),
      },
      initialRoute: '/myfirst',
    );
  }
}

class MyFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一页'),
        leading: FlutterLogo(colors: Colors.blue),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              print('点击了分享按钮');
              Navigator.pushNamed(context, '/mythird');
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              print('点击地图按钮');
              Navigator.pushNamed(context, '/google_map');
            },
          ),
          IconButton(
            icon: Icon(Icons.details),
            onPressed: () {
              Navigator.of(context).pushNamed('/nettest');
            },
          ),
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () {
              Navigator.of(context).pushNamed('/wxchapters');
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: RaisedButton(
          child: Text('Click here to next page'),
          onPressed: () {
            Navigator.pushNamed(context, '/mysecond');
//            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MySecondPage(),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        // create a tween
        var begin = Offset(0, 1);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
//        return child;

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class MySecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('这里就是第二页啦'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          child: Text('电一下，去到第三个页面'),
          onPressed: () {
            Navigator.pushNamed(context, '/mythird');
          },
        ),
      ),
    );
  }
}
