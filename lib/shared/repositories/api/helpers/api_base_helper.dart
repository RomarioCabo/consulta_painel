import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:painel_cunsulta/constants/strings.dart';
import 'api_exception.dart';

class ApiBaseHelper {
  Future<dynamic> post({
    @required String url,
    @required String body,
    String authorization,
  }) async {
    return await _request(
      httpMethod: "POST",
      authorization: authorization,
      url: url,
      body: body,
    );
  }

  Future<dynamic> put({
    @required String url,
    @required String body,
    @required String pathVariable,
    String authorization,
  }) async {
    return await _request(
      httpMethod: "PUT",
      authorization: authorization,
      url: url,
      pathVariable: pathVariable,
      body: body,
    );
  }

  Future<dynamic> delete({
    @required String url,
    @required String pathVariable,
    String authorization,
  }) async {
    return await _request(
      httpMethod: "DELETE",
      authorization: authorization,
      url: url,
      pathVariable: pathVariable,
    );
  }

  Future<dynamic> get({
    @required String url,
    String queryParams,
    String pathVariable,
    String authorization,
  }) async {
    return await _request(
      httpMethod: "GET",
      authorization: authorization,
      url: url,
      queryParams: queryParams,
      pathVariable: pathVariable,
    );
  }

  Future<dynamic> _request({
    @required String httpMethod,
    @required String url,
    String body,
    String queryParams,
    String pathVariable,
    String authorization,
  }) async {
    try {
      Map<String, String> headers;

      headers = {'Content-Type': 'application/json'};

      if(authorization != null) {
        headers.addAll({'Authorization': authorization});
      }

      queryParams = queryParams == null ? "" : "?$queryParams";
      pathVariable = pathVariable == null ? "" : "/$pathVariable";

      String uri = "$base_url$url$queryParams$pathVariable";

      if (!kReleaseMode) {
        print("URI: $uri");
      }

      var request = http.Request(httpMethod, Uri.parse(uri));

      if (body != null) {
        request.body = body;
      }

      request.headers.addAll(headers);

      http.Response response = await http.Response.fromStream(await request.send());

      return _returnResponse(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  dynamic _returnResponse(http.Response response) {
    if (!kReleaseMode) {
      print("${response.statusCode} ${utf8.decode(response.bodyBytes)}");
    }

    switch (response.statusCode) {
      case 201:
      case 200:
        if (response.bodyBytes.length == 0) {
          return null;
        } else {
          return json.decode(utf8.decode(response.bodyBytes));
        }

        break;
      case 400:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw BadRequestException(
          response.statusCode,
          error["message"],
        );

      case 401:
      case 403:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw UnauthorisedException(
          response.statusCode,
          error["message"],
        );

      case 500:
      default:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw FetchDataException(
          response.statusCode,
          error["message"],
        );
    }
  }
}
