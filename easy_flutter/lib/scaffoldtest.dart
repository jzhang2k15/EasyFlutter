import 'package:flutter/material.dart';

void main() => runApp(ScaffoldApp());

class ScaffoldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // 为这个 Widget  创建可变状态
    return _ScaffoldAppState();
  }
}

class _ScaffoldAppState extends State<ScaffoldApp> {
  String _title = '这里是第三个页面，有抽屉，FloatingActionButton';
  String _content = 'Scaffold';
  int _currentIndex = 0;// 底部导航栏的 index，默认第一个

  static const List<Widget> _list = <Widget>[
    Text('首页'),
    Text('通讯录'),
    Text('设置'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Center(
          child: _list.elementAt(_currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('首页')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              title: Text('通讯录')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('设置')
          ),
        ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blue,
          onTap: _onBottomBarTap,// 在底部选项卡被点击的时候调用，
        ),
        drawer: Drawer(
          child: Center(
            child: Text('抽屉'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_to_queue),
          onPressed: () {
            setState(() {
              _title = '恭喜你';
              _content = '你点击了按钮';
            });
          },
        ),
      ),
    );
  }

  void _onBottomBarTap(int index) {
    setState(() {
      // 将当前的索引值传递给 _currentIndex，并刷新页面
      _currentIndex = index;
    });
  }
}
