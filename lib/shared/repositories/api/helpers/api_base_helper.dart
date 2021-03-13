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
  }) async {

    return await _request(
      httpMethod: "POST",
      url: url,
      body: body,
    );
  }

  Future<dynamic> put({
    @required String url,
    @required String body,
    @required String pathVariable,
  }) async {

    return await _request(
      httpMethod: "PUT",
      url: url,
      pathVariable: pathVariable,
      body: body,
    );
  }

  Future<dynamic> delete({
    @required String url,
    @required String pathVariable,
  }) async {

    return await _request(
      httpMethod: "DELETE",
      url: url,
      pathVariable: pathVariable,
    );
  }

  Future<dynamic> get({
    @required String url,
    String queryParams,
    String pathVariable,
  }) async {

    return await _request(
      httpMethod: "GET",
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
  }) async {
    dynamic responseJson;

    try {
      var headers = {'Content-Type': 'application/json'};

      queryParams = queryParams == null ? "" : "?$queryParams";
      pathVariable = pathVariable == null ? "" : "/$pathVariable";

      if (!kReleaseMode) {
        print("$base_url$url$queryParams$pathVariable");
      }

      var request = http.Request(
          httpMethod, Uri.parse("$base_url$url$queryParams$pathVariable"));

      if (body != null) {
        request.body = body;
      }

      request.headers.addAll(headers);

      http.Response response =
          await http.Response.fromStream(await request.send());

      responseJson = _returnResponse(response);

      return responseJson;
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
        if(response.bodyBytes.length == 0) {
          return null;
        } else {
          return json.decode(utf8.decode(response.bodyBytes));
        }

        break;
      case 400:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw BadRequestException(
          response.statusCode,
          error["menssagem"],
        );

      case 401:
      case 403:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw UnauthorisedException(
          response.statusCode,
          error["menssagem"],
        );

      case 500:
      default:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw FetchDataException(
          response.statusCode,
          error["menssagem"],
        );
    }
  }
}
