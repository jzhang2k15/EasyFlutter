import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

// Widget 的物理模拟效果
class DraggableCardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DraggableCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard({this.child});

  @override
  _DraggableCardState createState() {
    return _DraggableCardState();
  }
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  // 让 widget 获得拖拽能力，添加一个范围
  Alignment _dragAlignment = Alignment.center;
  Animation<Alignment> _animation;

  @override
  Widget build(BuildContext context) {
    // 获取到 widget 的大小，也就是屏幕的大小，单位是 dp
    var size = MediaQuery.of(context).size;
    _printScreenInfo(size, context);
    // 使用 GestureDetector 来捕获点击、拖拽时候的回调
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          // dx、dy 都是相对上一个位置的偏移，记录了相对于原来位置的偏移量
          // 将获取到的 dx、dy 都除以 size 的 width、height 的一半，
          // 即可以转换为以控件为中心的坐标轴
          _dragAlignment += Alignment(details.delta.dx / (size.width / 2),
              details.delta.dy / (size.height / 2));
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      // Align Widget 的坐标轴范围是[-1, -1] 到 [1,1]，其中 [0, 0] 是坐标原点
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          // 就是上面的 Flutter logo
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    // 添加监听，当 controller 的值发生改变的时候回调
    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 执行动画，使 logo 回到原点
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    // 设置了动画的开始点以及终点
    _animation = _controller
        .drive(AlignmentTween(begin: _dragAlignment, end: Alignment.center));

    // 计算速率
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitsVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitsVelocity);

    _controller.animateWith(simulation);

//    _controller.reset();
//    _controller.forward();
  }

  // 打印屏幕信息
  void _printScreenInfo(Size size, BuildContext context) {
//    print("size = " + size.toString());
//    print(
//        "size,设备的像素密度 = " + MediaQuery.of(context).devicePixelRatio.toString());
//    print('window.physicalSize = ' + window.physicalSize.toString());
//    print("size.width = " + size.width.toString());
//    print("size.height = " + size.height.toString());
  }
}
