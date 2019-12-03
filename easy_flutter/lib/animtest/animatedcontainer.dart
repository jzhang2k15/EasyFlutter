import 'dart:math';

import 'package:flutter/material.dart';

// Container 渐变动画效果

// 1、创建一个有默认属性的 StatefulWidget
class AnimWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimWidgetState();
  }
}

class _AnimWidgetState extends State<AnimWidget> {
  // 定义有默认值的变量
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    // 2、创建一个使用这些属性的 AnimatedContainer(一个隐式动画 Widget)
    AnimatedContainer animatedContainer = AnimatedContainer(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );

    // 创建一个按钮触发动画
    FloatingActionButton floatingActionButton = FloatingActionButton(
      child: Icon(Icons.play_circle_filled),
      onPressed: () {
        setState(() {
          Random random = Random();

          // 创建随机的宽高
          _width = random.nextInt(300).toDouble();
          _height = random.nextInt(300).toDouble();

          // 创建随机的颜色
          _color = Color.fromRGBO(
              random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);

          // 创建随机的圆角
          _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
        });
      },
    );

    // 3、通过这些属性重建并触发动画，setState()

    return Scaffold(
      appBar: AppBar(
        title: Text('Container 渐变动画效果'),
      ),
      body: Center(
        child: animatedContainer,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
