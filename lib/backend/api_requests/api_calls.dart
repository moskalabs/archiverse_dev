import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

/*api call 방식 - default 연습한거 제공
const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetLicensedJsonCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetLicensedJson',
      apiUrl:
          'https://ygagwsshehmtfqlkjwmv.supabase.co/rest/v1/professor_myprofile?select=pfr_licensed',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlnYWd3c3NoZWhtdGZxbGtqd212Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMxMDIxNDMsImV4cCI6MjA0ODY3ODE0M30.8_duIDI0wSMe3c0_H0kxUYCt4eSEyQnOLNK-nGGd-RI',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlnYWd3c3NoZWhtdGZxbGtqd212Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMxMDIxNDMsImV4cCI6MjA0ODY3ODE0M30.8_duIDI0wSMe3c0_H0kxUYCt4eSEyQnOLNK-nGGd-RI',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
} */

class DegreeTextFieldCall {
  static Future<ApiCallResponse> call({
    dynamic degreeTextFieldJson,
  }) async {
    final degreeTextField = _serializeJson(degreeTextFieldJson);
    final ffApiRequestBody = '''
${degreeTextField}''';
    return ApiManager.instance.makeApiCall(
      callName: 'degreeTextField',
      apiUrl:
          'https://ygagwsshehmtfqlkjwmv.supabase.co/rest/v1/professor_myprofile?some_column=eq.someValue',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
