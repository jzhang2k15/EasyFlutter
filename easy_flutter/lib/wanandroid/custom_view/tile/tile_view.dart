import 'package:easy_flutter/wanandroid/custom_view/tile/tile_chess.dart';
import 'package:easy_flutter/wanandroid/custom_view/tile/tile_table.dart';
import 'package:flutter/material.dart';

/// 自定义棋盘
class TileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TileViewState();
  }
}

class TileViewState extends State<TileView> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,// 固定宽高比例
      child: Stack(// 相当于 FrameLayout
        textDirection: TextDirection.ltr,// 文字左至右的布局
        fit: StackFit.expand,// 相当于 match_parent
        children: <Widget>[
          // 放置棋盘背景
          TileTable(borderCount: 19),
          // 放置棋子
          TileChess(borderCount: 19,),
        ],
      ),
    );
  }
}
