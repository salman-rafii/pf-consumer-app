// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:pf_consumer_app/data/model/response.dart';
import 'package:pf_consumer_app/data/model/response/error_response.dart';
import 'package:pf_consumer_app/utils/app_constants.dart';
// import 'package:ppf_consumer/providers/auth_provider.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage =
      'Connection to server failed please check you internet connection';
  final int timeoutInSeconds;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
    required this.ref,
    this.timeoutInSeconds = 120,
  });
  Ref ref;
  void updateHeader() {
    token = sharedPreferences.getString(AppConstants.token);
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    updateHeader();
    try {
      if (kDebugMode) {
        Logger().d({
          'url': AppConstants.baseUrl + uri,
          'headers': _mainHeaders,
        });
      }
      http.Response res = await http
          .get(Uri.parse(appBaseUrl + uri), headers: headers ?? _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(res, uri);
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData<T>(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    updateHeader();

    try {
      if (kDebugMode) {
        Logger().d({
          'url': AppConstants.baseUrl + uri,
          'headers': _mainHeaders,
          'body': body,
        });
      }
      http.Response res = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse<T>(res, uri);
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      Logger().e(e);
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
    String uri,
    Map<String, String?> body,
    List<MultipartBody> multipartBody, {
    Map<String, String>? headers,
  }) async {
    updateHeader();
    try {
      if (kDebugMode) {
        Logger().d({
          'url': AppConstants.baseUrl + uri,
          'headers': _mainHeaders,
          'body': body,
        });
      }
      http.MultipartRequest req = http.MultipartRequest(
        'POST',
        Uri.parse(appBaseUrl + uri),
      );
      req.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          if (kIsWeb) {
            Uint8List l = await multipart.file!.readAsBytes();
            http.MultipartFile part = http.MultipartFile(
              multipart.key,
              multipart.file!.readAsBytes().asStream(),
              l.length,
              filename: basename(multipart.file!.path),
              // contentType: MediaType('image', 'jpg'),
            );
            req.files.add(part);
          } else {
            File f = File(multipart.file!.path);
            req.files.add(
              http.MultipartFile(
                multipart.key,
                f.readAsBytes().asStream(),
                f.lengthSync(),
                filename: f.path.split('/').last,
              ),
            );
          }
        }
      }
      req.fields.addAll(body as Map<String, String>);
      http.Response res = await http.Response.fromStream(await req.send());
      return handleResponse(res, uri);
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    updateHeader();
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      http.Response res = await http
          .put(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(res, uri);
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(
    String uri, {
    Map<String, String>? headers,
  }) async {
    updateHeader();
    try {
      if (kDebugMode) {
        Logger().d({'url': AppConstants.baseUrl + uri, 'headers': headers});
      }
      http.Response res = await http
          .delete(Uri.parse(appBaseUrl + uri), headers: headers ?? _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(res, uri);
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse<T>(http.Response response, String uri) {
    if (kDebugMode) {
      Logger().f({
        'uri': uri,
        'code': response.statusCode,
        'body': response.body,
      });
    }
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
    }

    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase ?? 'Unknown error occurred',
    );

    if (response0.status.isOk && response0.body != null) {
      response0 = Response(
        body: body,
        statusCode: response.statusCode,
        statusText: '',

        /// _body['message'] == null ? '' : _body['message'],
      );
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
      response0 = Response(
        statusCode: response0.statusCode,
        body: response0.body,
        statusText: body['message'],
      );

      if (response0.statusCode == HttpStatus.unauthorized) {
        // ref.read(authProvider).saveLogOut();
      }
    }

    return response0;
  }

  basename(String path) {
    return path;
  }
}

class MultipartBody {
  String key;
  File? file;

  MultipartBody(this.key, this.file);
}
