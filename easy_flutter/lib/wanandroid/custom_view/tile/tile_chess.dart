import 'dart:math';

import 'package:flutter/material.dart';

class TileChess extends StatefulWidget {
  /// Border count
  int borderCount;

  TileChess({@required this.borderCount});

  @override
  State<StatefulWidget> createState() {
    return TileChessState();
  }
}

class TileChessState extends State<TileChess> {
  /// 用来存储棋子的数组
  List<Chess> _chessList = List();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        print('宽高 = ${context.size.width}, ${context.size.height}');
        print('点击事件：${details.localPosition.toString()}');
        _drawChess(details.localPosition);
      },
      child: CustomPaint(
        painter: Painter(borderCount: widget.borderCount, list: _chessList),
      ),
    );
  }

  void _drawChess(Offset offset) {
    var chess = Chess(x: offset.dx.toInt(), y: offset.dy.toInt());
    if (_chessList.contains(chess)) {
      print('已经下过这里了');
      return;
    }
    if (!Painter.isValidChess(chess)) {
      print('无效的棋子-边界越限');
      return;
    }
    setState(() {
      _chessList.add(chess);
    });
  }
}

class Painter extends CustomPainter {
  Canvas _canvas;
  Paint _paintBlack;
  Paint _paintWhite;

  /// 棋子的列表
  List<Chess> list;
  int borderCount;

  /// 每个空隙的宽度
  static double _tileSize;
  static double _width;

  /// Offset horizontal
  static double _xOffset;

  /// Offset vertical
  static double _yOffset;

  Painter({@required this.borderCount, @required this.list});

  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    if (_width == null) {
      _width = min(size.width, size.height);
      print('painter 宽高 = $_width, $_width');
      _tileSize = _width / (borderCount + 1);
      _xOffset = _yOffset = _tileSize;
      print('offset = $_xOffset, $_yOffset');
    }
    if (_canvas == null) {
      _canvas = canvas;
      _paintBlack = Paint()..color = Colors.black;
      _paintWhite = Paint()..color = Colors.white;
    }
    _drawChess(list);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawChess(List<Chess> list) {
    if (_canvas != null) {
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          var chess = list[i];
          var real = getRealXY(chess);
          _canvas.drawOval(
              Rect.fromCircle(
                  center: Offset(
                      (real.dx + 1) * _tileSize, (real.dy + 1) * _tileSize),
                  radius: 8),
              i % 2 == 0 ? _paintBlack : _paintWhite);
        }
      }
    } else {
      print('画笔为空，请检查');
    }
  }

  Offset getRealXY(Chess chess) {
    /// 获取到没有左边和上边空隙的左边
    var xNoSpace = chess.x - _xOffset / 2;
    var yNoSpace = chess.y - _yOffset / 2;

    /// 整除获取真实的 xy
    var realX = xNoSpace ~/ _tileSize;
    var realY = yNoSpace ~/ _tileSize;
    return Offset(realX.toDouble(), realY.toDouble());
  }

  static bool isValidChess(Chess chess) {
    print('isValidChess');
    print(chess.x);
    print(_xOffset);

    if (chess.x < (_xOffset / 2) ||
        chess.x > (_width - (_xOffset / 2)) ||
        chess.y < (_yOffset / 2) ||
        chess.y > (_width - (_yOffset / 2))) {
      return false;
    }
    return true;
  }
}

/// 棋子，xy 是用户点击的坐标，不是棋盘上棋子中心的坐标
class Chess {
  int x;
  int y;

  Chess({@required this.x, @required this.y});
}
