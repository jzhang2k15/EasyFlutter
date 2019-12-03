import 'package:flutter/material.dart';

class MyDefaultTabController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab 实例'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: '热点'),
              Tab(text: '体育'),
              Tab(text: '科技'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(child: Text('热点页面详情'),),
            Center(child: Text('体育页面详情'),),
            Center(child: Text('科技页面详情'),),
          ],
        ),
      ),
    );
  }
}

class MyCustomTabController extends StatefulWidget {
  @override
  _MyCustomTabControllerState createState() {
    return _MyCustomTabControllerState();
  }
}

class _MyCustomTabControllerState extends State<MyCustomTabController>
    with SingleTickerProviderStateMixin {

  TabController _controller; // 自定义的 controller

  @override
  void initState() {
    super.initState();
    print('initState');
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义的 TabController'),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(text: '热点'),
            Tab(text: '体育'),
            Tab(text: '科技'),
          ],
          controller: _controller,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          Center(child: Text('热点页面详情'),),
          Center(child: Text('体育页面详情'),),
          Center(child: Text('科技页面详情'),),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('dispose');
    _controller.dispose();
    super.dispose();
  }
}