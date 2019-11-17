import 'package:flutter/material.dart';

void main() => runApp(ScaffoldApp());

class ScaffoldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaffoldAppState();
  }
}

class _ScaffoldAppState extends State<ScaffoldApp> {

  String _title = '这里是第三个页面，有抽屉，一个空的底部导航栏，FloatingActionButton';
  String _content = 'Scaffold';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Text(_content),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
          ),
        ),
        drawer: Drawer(
          child: Center(
            child: Text('抽屉'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_to_queue),
          onPressed: (){
            setState(() {
              _title = '恭喜你';
              _content = '你点击了按钮';
            });
          },
        ),
      ),
    );
  }
}