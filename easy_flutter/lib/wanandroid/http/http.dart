import 'package:dio/dio.dart';

// 封装网络请求类，只处理 Http 请求部分，服务器的返回需要自己去做解析
class HttpUtils {
  Dio _dio;
  static const _tag = 'HttpUtils';
  static const _baseUrl = 'https://wanandroid.com/';
  static const String method_get = 'get';
  static const String method_post = 'post';
  static const int ok = 200;
  static const int notFound = 404;
  static const int internal_error = 500;

  // 使用 static final 修饰 sInstance，会在编译期就被初始化，保证内存里面仅一份实例
  static final HttpUtils sInstance = HttpUtils._getInstance();

  // 对外界提供工厂方法来提供这个类的实例
  factory HttpUtils() => sInstance;

  // 私有的具名构造方法，隐藏了构造方法
  HttpUtils._getInstance() {
    // 保证 dio 唯一
    if (_dio == null) {
      BaseOptions options = BaseOptions();
      options.baseUrl = _baseUrl;
      options.connectTimeout = 5 * 1000;
      options.receiveTimeout = 10 * 1000;
      _dio = Dio(options);
    }
  }

  void get(String url, Function callback,
      {Map<String, dynamic> params, Function errorCallback}) {
    _request(url, callback, method: method_get, errorCallback: errorCallback);
  }

  void post(String url, Function callback,
      {Map<String, dynamic> params, Function errorCallback}) {
    _request(url, callback, method: method_post, errorCallback: errorCallback);
  }

  // 封装请求方法
  void _request(String url, Function callback,
      {String method,
      Map<String, dynamic> params,
      Function errorCallback}) async {
    try {
      Response response;
      // 判断请求类型，并发起对应的请求
      if (method == method_get) {
        if (params != null && params.isNotEmpty) {
          response = await _dio.get(url, queryParameters: params);
        } else {
          response = await _dio.get(url);
        }
      } else if (method == method_post && params.isNotEmpty) {
        if (params != null) {
          response = await _dio.post(url, queryParameters: params);
        } else {
          response = await _dio.post(url);
        }
      }

      // 请求完成，返回，或者抛出错误
      switch (response.statusCode) {
        case ok:
          callback(response.data);
          break;
        case internal_error:
          _handleError(errorCallback, '内部错误');
          break;
        default:
          _handleError(errorCallback,
              '未知错误, errorCode: ${response.statusCode}, errorMsg: ${response.statusMessage}');
          break;
      }
    } catch (e) {
      _handleError(errorCallback, e.toString());
    }
  }

  void _handleError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorCallback);
    }
    print('错误信息: $errorMsg');
  }
}
