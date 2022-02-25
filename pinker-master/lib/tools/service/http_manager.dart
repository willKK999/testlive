import 'package:dio/dio.dart';

enum HttpMethod { GET, POST }

class HttpManager {
  static Dio? _dioInstance;
  static Dio getDioInstance() {
    if (_dioInstance == null) {
      _dioInstance = Dio();
    }
    return _dioInstance;
  }

  static Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) {
    return Dio().get(url, queryParameters: queryParameters);
  }

  static Future sendRequest(HttpMethod method, String url,
      {dynamic data, Map<String, dynamic>? queryParameters}) {
    try {
      switch (HttpMethod) {
        case HttpMethod.GET:
          return Dio().get(url, queryParameters: queryParameters);
        case HttpMethod.POST:
          return Dio().post(url, data: data, queryParameters: queryParameters);
        default:
          return Exception('请求方式错误');
      }
    } on DioError catch (e) {
      print(e.toString());
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
