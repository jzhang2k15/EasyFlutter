import 'package:flutter/material.dart';

void main() => runApp(AncestorApp());

class AncestorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Test',
      home: Ancestor1(),
    );
  }

  void print1() {
    print(1);
  }
}

class Ancestor1 extends StatelessWidget {
  var _btn1 = AncestorButton(1);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Title'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _btn1,
            AncestorButton(2),
          ],
        ),
      ),
    );
  }
}

class AncestorButton extends StatelessWidget {

  AncestorButton(int key){
    _key = key;
  }

  int _key;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        print('context = $context');
        var ancestor = context.ancestorWidgetOfExactType(Text);
        Navigator.of(context);
        print('祖先$_key = $ancestor');
      },
    );
  }
}
