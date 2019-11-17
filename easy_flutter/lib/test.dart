import 'package:easy_flutter/scaffoldtest.dart';
import 'package:flutter/material.dart';

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
        '/mysecond': (BuildContext context) => MySecondPage(),
        '/mythird': (BuildContext context) => ScaffoldApp()
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
            onPressed: (){
              print('点击了分享按钮');
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: RaisedButton(
          child: Text('Click here to next page'),
          onPressed: (){
            Navigator.pushNamed(context, '/mysecond');
          },
        ),
      ),
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
