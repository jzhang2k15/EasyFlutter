import 'package:easy_flutter/entity_factory.dart';
import 'package:easy_flutter/wanandroid/bean/wx_chapters_entity.dart';
import 'package:easy_flutter/wanandroid/http/api.dart';
import 'package:easy_flutter/wanandroid/http/http.dart';
import 'package:flutter/material.dart';

// 公众号列表页
class WxChapters extends StatefulWidget {
  @override
  createState() {
    return WxChaptersState();
  }
}

class WxChaptersState extends State<WxChapters> {
  // 定义一个公众号列表
  final _chapters = <WxChaptersData>[];

  // 是否已经在请求数据
  bool _isRequestData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('公众号列表'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: _getItemBuilder,
      ).build(context),
    );
  }

  Widget _getItemBuilder(BuildContext context, int i) {
    // 单行的时候设置分界线
    if (i.isOdd) return Divider();

    if (!_isRequestData) {
      _doGetChapters();
    }
    // 整除(向下取整)，获取到列表的 index
    final index = i ~/ 2;
    if (_chapters.length > 0 && index < _chapters.length) {
      return _getItem(_chapters[index]);
    } else {
      print('当前没有更多数据, index = $index');
      return null;
    }
  }

  // 创建列表
  Widget _getItem(WxChaptersData chapter) {
    return ListTile(
      title: Text(chapter.name),
      onTap: () {
        Navigator.pushNamed(context, '/wx_chapters_history',
            arguments: chapter);
      },
    );
  }

  // GET 请求获取公众号列表
  void _doGetChapters() {
    print('发起网络请求，获取公众号列表');
    HttpUtils.sInstance.get(apiGetChapters, (data) {
      WxChaptersEntity entity =
          EntityFactory.generateOBJ<WxChaptersEntity>(data);
      print('请求列表成功: code = ${entity.errorCode}, msg = ${entity.errorMsg}');
      for (var value in entity.data) {
        print(value.toJson());
      }
      setState(() {
        _chapters.addAll(entity.data);
        _isRequestData = true;
      });
    });
  }
}
