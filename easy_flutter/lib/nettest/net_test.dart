import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_flutter/nettest/bean/user_model.dart';
import 'package:flutter/material.dart';

class NetTest extends StatefulWidget {
  @override
  createState() {
    return NetTestState();
  }
}

class NetTestState extends State<NetTest> {
  // 手动解析的 json 数据
  String _baseJsonString = '{"name": "John Smith","email": "john@example.com"}';
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网络请求测试'),
        actions: <Widget>[
          // Json 测试按钮
          _getJsonButton(),
          // 网络请求测试按钮
          _getHttpGETButton(),
        ],
      ),
    );
  }

  // 生成一个 Json 测试按钮
  IconButton _getJsonButton() {
    return IconButton(
      icon: Icon(Icons.details),
      onPressed: () {
        // 手动解析
        Map<String, dynamic> decodeMap = jsonDecode(_baseJsonString);
        String name = decodeMap['name'];
        String email = decodeMap['email'];
        print('name = $name');
        print('email = $email');

        // 通过 User 类进行解析，解析的工作交给 User 类
        var user = User.fromJson(decodeMap);
        print('user.name = ${user.name}');
        print('user.email = ${user.email}');
      },
    );
  }

  // 发送 Get 请求
  IconButton _getHttpGETButton() {
    return IconButton(
      icon: Icon(Icons.network_wifi),
      onPressed: () {
        print('点击进行网络请求');
        _doGet();
      },
    );
  }

  void _doGet() async {
    try {
      // 获取公众号列表
//      Response response = await _dio.get('http://www.baidu.com');
      Response response = await _dio.get('https://wanandroid.com/wxarticle/chapters/json');
      print('结果' + response.toString());
    } catch (e) {
      e.toString();
    }
  }
}
