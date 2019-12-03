import 'package:easy_flutter/wanandroid/bean/wx_chapters_entity.dart';
import 'package:easy_flutter/wanandroid/bean/wx_chapter_histories_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "WxChaptersEntity") {
      return WxChaptersEntity.fromJson(json) as T;
    } else if (T.toString() == "WxChapterHistoriesEntity") {
      return WxChapterHistoriesEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}