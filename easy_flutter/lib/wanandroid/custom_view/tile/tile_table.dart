import 'dart:math';

import 'package:flutter/material.dart';

/// 棋盘
class TileTable extends StatefulWidget {
  /// 多少条线
  int borderCount;

  TileTable({@required this.borderCount});

  @override
  State<StatefulWidget> createState() {
    return TileTableStage();
  }
}

class TileTableStage extends State<TileTable> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Painter(widget.borderCount),
    );
  }
}

class Painter extends CustomPainter {
  /// Border count
  int _borderCount;

  /// Size of each tile
  double _tileSize;

  /// Offset horizontal
  double _xOffset;

  /// Offset vertical
  double _yOffset;

  /// Width
  double _width;

  /// Paint
  Paint _paintBg;
  Paint _paintLine;

  Painter(this._borderCount) {
    print('Construct Painter..');
    _paintBg = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 15;
    _paintLine = Paint()..color = Colors.black;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制 UI
    if (_width == null) {
      _width = min(size.width, size.height);
    }
    if (_tileSize == null) {
      _tileSize = _width / (_borderCount + 1);
      _xOffset = _yOffset = _tileSize;
      print('borderCount = $_borderCount');
      print('width = $_width');
      print('tileSize = $_tileSize');
      print('xOffset = $_xOffset');
      print('yOffset = $_yOffset');
    }
    canvas.drawRect(Rect.fromLTWH(0, 0, _width, _width), _paintBg);
    _drawLine(canvas);
    _drawText(canvas);
    _drawStars(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawLine(Canvas canvas) {
    for (int i = 0; i < _borderCount; i++) {
      canvas.drawLine(Offset(_getXScreen(i), _getYScreen(0)),
          Offset(_getXScreen(i), _getYScreen(_borderCount - 1)), _paintLine);
      canvas.drawLine(Offset(_getXScreen(0), _getYScreen(i)),
          Offset(_getXScreen(_borderCount - 1), _getYScreen(i)), _paintLine);
    }
  }

  void _drawText(Canvas canvas) {
    /// 遍历每一条线，然后在线上标记
    for (int i = 0; i < _borderCount; i++) {
      /// 没有 canvas 没有 drawText 的 api，只有通过 TextPainter 来操作
      /// 横轴 A-S
      /// 纵轴 1-19
      var xSpan = TextSpan(
        text: '${i + 1}',
        style: TextStyle(
          color: Colors.black,
          fontSize: _tileSize * 2 / 5,
        ),
      );

      /// layout 方法调用前，必传 text 和textDirection，否则报错
      var xPainter = TextPainter(text: xSpan, textDirection: TextDirection.ltr);
      xPainter.layout();
//      print(
//          'xPainter.width = ${xPainter.width}, xPainter.height = ${xPainter.height}');
      xPainter.paint(
          canvas,
          Offset(_getXScreen(i) - xPainter.width / 2,
              (_yOffset - xPainter.height) / 2));

      var ySpan = TextSpan(
          text: _getYAlphabet(i),
          style: TextStyle(
            color: Colors.black,
            fontSize: _tileSize * 2 / 5,
          ));

      var yPainter = TextPainter(text: ySpan, textDirection: TextDirection.ltr);
      yPainter.layout();
      yPainter.paint(
          canvas,
          Offset((_xOffset - yPainter.width) / 2,
              _getYScreen(i) - yPainter.height / 2));
    }
  }

  void _drawStars(Canvas canvas) {
    double starSize = _borderCount <= 9 ? _tileSize / 10 : _tileSize / 8;
    var stars = CoordinateUtils.createStar();
    for (Coordinate coordinate in stars) {
      canvas.drawOval(
          Rect.fromCircle(
              center:
                  Offset(_getXScreen(coordinate.x), _getYScreen(coordinate.y)),
              radius: starSize),
          _paintLine);
    }
  }

  String _getYAlphabet(int index) {
    String alphabet = 'ABCDEFGHIJKLMNOPQRS';
    return alphabet[index];
  }

  double _getXScreen(int i) {
    return i * _tileSize + _xOffset;
  }

  double _getYScreen(int i) {
    return i * _tileSize + _yOffset;
  }
}

/// 星位坐标
class Coordinate {
  int x;
  int y;

  Coordinate({@required this.x, @required this.y});
}

/// 星位坐标工具类
class CoordinateUtils {
  static List<Coordinate> createStar() {
    List<Coordinate> list = List();
    List<int> listLine = [3, 9, 15];
    for (var value in listLine) {
      for (int i = 0; i < listLine.length; i++) {
        list.add(Coordinate(x: listLine[i], y: value));
      }
    }
    return list;
  }
}
