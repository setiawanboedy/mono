import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_exceptions.dart';

enum CallType { post, get, put, patch, delete }

typedef ErrorInterceptor = String? Function(http.Response response);

class Api {
  Api({
    required this.apiUrl,
    this.timeoutSeconds = 10,
    this.errorMessageInterceptor,
  });

  final String apiUrl;
  final int timeoutSeconds;
  final ErrorInterceptor? errorMessageInterceptor;

  Future<http.Response> apiCall({
    required CallType callType,
    required String endpoint,
    String? token,
    Map<String, String>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    late String url;
    if (queryParams != null) {
      final String paramsString = Uri(queryParameters: queryParams).query;
      url = '$apiUrl$endpoint?$paramsString';
    } else {
      url = '$apiUrl$endpoint';
    }
    final Uri uri = Uri.parse(url);

    final Map<String, String> headers = <String, String>{
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    Future<http.Response> future;
    switch (callType) {
      case CallType.post:
        future = http.post(uri, headers: headers, body: body);
        break;
      case CallType.get:
        future = http.get(uri, headers: headers);
        break;
      case CallType.put:
        future = http.put(uri, headers: headers, body: body);
        break;
      case CallType.patch:
        future = http.patch(uri, headers: headers, body: body);
        break;
      case CallType.delete:
        future = http.delete(uri, headers: headers, body: body);
        break;
    }

    http.Response response;
    try {
      response = await future.timeout(Duration(seconds: timeoutSeconds));
    } on TimeoutException catch (_) {
      throw _createClientException(
          ClientExceptionType.timoutException, callType, endpoint, null);
    }

    errorCheck(response, callType, endpoint);

    return response;
  }

  Exception _createClientException(
    ClientExceptionType exceptionType,
    CallType type,
    String endpoint,
    String? parsedErrorMessage,
  ) {
    if (parsedErrorMessage != null) {
      return ClientException(exceptionType, parsedErrorMessage);
    } else {
      final String callType = type.toString().split('.').last.toUpperCase();
      final String message = '$callType $endpoint';
      return ClientException(exceptionType, message);
    }
  }

  Exception _createServerException(
    String type,
  ) {
    return InternalServerError(type);
  }

  String? parseErrorMessage(http.Response response) {
    if (errorMessageInterceptor != null) {
      return errorMessageInterceptor!(response);
    }
    return null;
  }

  void errorCheck(
    http.Response response,
    CallType callType,
    String endpoint,
  ) {
    // client exceptions
    if (response.statusCode >= 400 && response.statusCode < 500) {
      ClientExceptionType clientExceptionType = ClientExceptionType.undefined;
      if (clientExceptionTypes.containsKey(response.statusCode)) {
        clientExceptionType = clientExceptionTypes[response.statusCode]!;
      }
      throw _createClientException(
        clientExceptionType,
        callType,
        endpoint,
        parseErrorMessage(response),
      );
    }

    // internal server errors
    if (response.statusCode >= 500 && response.statusCode < 600) {
      String errorType = 'Uknown Server Error';
      if (serverErrorTypes.containsKey(response.statusCode)) {
        errorType = serverErrorTypes[response.statusCode]!;
      }
      throw _createServerException(
        errorType,
      );
    }
  }

  static const Map<int, ClientExceptionType> clientExceptionTypes =
      <int, ClientExceptionType>{
    400: ClientExceptionType.badRequestException,
    401: ClientExceptionType.unauthorizedException,
    403: ClientExceptionType.forbiddenException,
    404: ClientExceptionType.notFoundException,
  };

  static const Map<int, String> serverErrorTypes = <int, String>{
    500: 'Internal Server Error',
    501: 'Not Implemented',
    502: 'Bad Gateway',
    503: 'Service Unavailable',
    504: 'Gateway Timeout',
    505: 'HTTP Version Not Supported',
    506: 'Variant Also Negotiates',
    507: 'Insufficient Storage',
    508: 'Loop Detected',
    510: 'Not Extended',
    511: 'Network Authentication Required',
    599: 'Network Connect Timeout Error',
  };
}
