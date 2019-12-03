// 具体某个公众号的历史文章页
import 'package:easy_flutter/wanandroid/bean/wx_chapter_histories_entity.dart';
import 'package:easy_flutter/wanandroid/bean/wx_chapters_entity.dart';
import 'package:easy_flutter/wanandroid/http/api.dart';
import 'package:easy_flutter/wanandroid/http/http.dart';
import 'package:flutter/material.dart';

class WxChapterHistories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WxChapterHistoriesState();
  }
}

class WxChapterHistoriesState extends State<WxChapterHistories> {
  WxChaptersData _chaptersData;
  int _currentPage = 1;
  bool _isNoMoreData = false;
  List<WxChapterHistoriesDataData> _list = <WxChapterHistoriesDataData>[];

  @override
  Widget build(BuildContext context) {
    _chaptersData = ModalRoute.of(context).settings.arguments;

    print('公众号历史页面的具体' + _chaptersData.toJson().toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('公众号历史文章页'),
      ),
      body: ListView.builder(
              padding: EdgeInsets.all(0), itemBuilder: _getItemBuilder)
          .build(context),
    );
  }

  Widget _getItemBuilder(BuildContext context, int i) {
    if (i.isOdd) return Divider();

    int index = i ~/ 2;
    if (index >= _list.length && !_isNoMoreData) {
      _getChapterHistories(_chaptersData);
    }else if(index == _list.length && _isNoMoreData){
      print('没有更多数据了');
    }
    if (_list.length > 0 && index < _list.length) {
      return _getItem(_list[index]);
    } else {
      return null;
    }
  }

  // 获取公众号历史文章
  void _getChapterHistories(WxChaptersData chaptersData) {
    print('开始获取历史文章');
    HttpUtils.sInstance.get(
        '$apiGetChapterHistories/list/${chaptersData.id}/$_currentPage/json',
        (data) {
      print('获取历史文章回调');
      print('data = ${data.toString()}');
      WxChapterHistoriesEntity historiesEntity =
          WxChapterHistoriesEntity.fromJson(data);
      // 没有超过最大的页数的时候，页数+1
      if (_currentPage < historiesEntity.data.pageCount) {
        _currentPage = historiesEntity.data.curPage + 1;
      } else {
        _isNoMoreData = true;
      }
      setState(() {
        _list.addAll(historiesEntity.data.datas);
      });
    });
  }

  Widget _getItem(WxChapterHistoriesDataData entity) {
    return ListTile(
      title: Text(entity.title),
    );
  }
}
