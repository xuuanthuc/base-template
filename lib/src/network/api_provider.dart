import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../public/utilities/logger.dart';
import 'error_code.dart';
import 'exception.dart';

@singleton
class ApiProvider {
  var dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      contentType: Headers.jsonContentType,
    ),
  );

  void _addInterceptors(Dio dio, {bool? needToken}) {
    dio
      ..interceptors.clear()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) =>
              _requestInterceptor(options, handler, needToken: needToken),
        ),
      );
  }

  void _requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler,
      {bool? needToken}) async {
    String token = '';
    if (needToken == true) {
      // token = await AppPreference().authToken ?? '';
      LoggerUtils.d('BEARER: $token');
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    options.headers.addAll({'Content-Type': 'application/json; charset=utf-8'});
    handler.next(options);
  }

  Future<dynamic> request({
    String? rawData,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    FormData? formParams,
    required String method,
    required String url,
    bool? needToken,
  }) async {
    var responseJson = {};
    try {
      _addInterceptors(dio, needToken: needToken);
      final response = await dio.request(
        url,
        queryParameters: queryParams,
        data: (formParams != null)
            ? formParams
            : (data != null)
                ? data
                : rawData,
        options: Options(
          method: method,
          validateStatus: (code) {
            return code! >= 200 && code < 300;
          },
        ),
      );
      LoggerUtils.i(response.data);
      response.data = {
        "data": [
          {
            "userId": 5,
            "id": 49,
            "title": "laborum non sunt aut ut assumenda perspiciatis voluptas",
            "body":
                "inventore ab sint\nnatus fugit id nulla sequi architecto nihil quaerat\neos tenetur in in eum veritatis non\nquibusdam officiis aspernatur cumque aut commodi aut"
          },
          {
            "userId": 5,
            "id": 50,
            "title":
                "repellendus qui recusandae incidunt voluptates tenetur qui omnis exercitationem",
            "body":
                "error suscipit maxime adipisci consequuntur recusandae\nvoluptas eligendi et est et voluptates\nquia distinctio ab amet quaerat molestiae et vitae\nadipisci impedit sequi nesciunt quis consectetur"
          },
          {
            "userId": 6,
            "id": 51,
            "title": "soluta aliquam aperiam consequatur illo quis voluptas",
            "body":
                "sunt dolores aut doloribus\ndolore doloribus voluptates tempora et\ndoloremque et quo\ncum asperiores sit consectetur dolorem"
          },
          {
            "userId": 6,
            "id": 52,
            "title":
                "qui enim et consequuntur quia animi quis voluptate quibusdam",
            "body":
                "iusto est quibusdam fuga quas quaerat molestias\na enim ut sit accusamus enim\ntemporibus iusto accusantium provident architecto\nsoluta esse reprehenderit qui laborum"
          },
          {
            "userId": 6,
            "id": 53,
            "title": "ut quo aut ducimus alias",
            "body":
                "minima harum praesentium eum rerum illo dolore\nquasi exercitationem rerum nam\nporro quis neque quo\nconsequatur minus dolor quidem veritatis sunt non explicabo similique"
          },
          {
            "userId": 6,
            "id": 54,
            "title": "sit asperiores ipsam eveniet odio non quia",
            "body":
                "totam corporis dignissimos\nvitae dolorem ut occaecati accusamus\nex velit deserunt\net exercitationem vero incidunt corrupti mollitia"
          },
          {
            "userId": 6,
            "id": 55,
            "title": "sit vel voluptatem et non libero",
            "body":
                "debitis excepturi ea perferendis harum libero optio\neos accusamus cum fuga ut sapiente repudiandae\net ut incidunt omnis molestiae\nnihil ut eum odit"
          },
          {
            "userId": 6,
            "id": 56,
            "title": "qui et at rerum necessitatibus",
            "body":
                "aut est omnis dolores\nneque rerum quod ea rerum velit pariatur beatae excepturi\net provident voluptas corrupti\ncorporis harum reprehenderit dolores eligendi"
          }
        ]
      };
      responseJson = _formatRes(
        response.statusCode,
        response.data,
        response.headers,
      );
    } on SocketException {
      throw ErrorException(ErrorCode.NO_NETWORK, 'NO_NETWORK');
    } on DioError catch (e) {
      debugPrint('error = $e');
      if (e.type == DioErrorType.connectTimeout) {
        throw ErrorException(ErrorCode.NO_NETWORK, 'NO_NETWORK');
      }
      throw ErrorException(e.response?.statusCode, e.response?.data['error']);
    }
    return responseJson;
  }

  Future get(String url,
      {Map<String, dynamic>? params, bool? needToken}) async {
    return await request(
      method: Method.get,
      url: url,
      queryParams: params,
      needToken: needToken ?? true,
    );
  }

  Future postMultiPart(String url, FormData formData, {bool? needToken}) async {
    return await request(
      method: Method.post,
      url: url,
      formParams: formData,
      needToken: needToken ?? true,
    );
  }

  Future putMultiPart(String url, FormData formData, {bool? needToken}) async {
    return await request(
      method: Method.put,
      url: url,
      formParams: formData,
      needToken: needToken ?? true,
    );
  }

  Future post(String url,
      {Map<String, dynamic>? params, bool? needToken}) async {
    return await request(
      method: Method.post,
      url: url,
      data: params,
      needToken: needToken ?? true,
    );
  }

  Future put(String url,
      {Map<String, dynamic>? params, bool? needToken}) async {
    return await request(
      method: Method.put,
      url: url,
      data: params,
      needToken: needToken ?? true,
    );
  }

  Future delete(String url,
      {Map<String, dynamic>? params, bool? needToken}) async {
    return await request(
      method: Method.delete,
      url: url,
      data: params,
      needToken: needToken ?? true,
    );
  }

  Future patch(String url,
      {Map<String, dynamic>? params, bool? needToken}) async {
    return await request(
      method: Method.patch,
      url: url,
      data: params,
      needToken: needToken ?? true,
    );
  }

  dynamic _formatRes(int? code, dynamic data, Headers header) {
    switch (code) {
      case ErrorCode.HTTP_OK:
        return data;
      case ErrorCode.HTTP_BAD_REQUEST:
        throw BadRequestException(data['message']);
      case ErrorCode.HTTP_UNAUTHORIZED:
      case ErrorCode.HTTP_FORBIDDEN:
        throw UnauthorisedException(data['message']);
      case ErrorCode.HTTP_INTERNAL_SERVER_ERROR:
      default:
        throw ErrorException(code,
            'Error occured while Communication with Server with StatusCode : $code');
    }
  }
}

class Method {
  static String get get => 'get';

  static String get post => 'post';

  static String get patch => 'patch';

  static String get put => 'put';

  static String get delete => 'delete';
}
