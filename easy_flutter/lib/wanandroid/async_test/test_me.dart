import 'package:easy_flutter/wanandroid/custom_view/tile/tile_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(CountPage());

class CountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      home: InitView(),
    );
  }
}

class InitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        fit: StackFit.expand,
        children: <Widget>[
          TileView(),
        ],
      ),
    );
  }
}
