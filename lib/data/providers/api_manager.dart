import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:questionnaire/app/app_constants.dart';
import 'package:retry/retry.dart';

import '../../app/app_typedefs.dart';
import '../models/api_response.dart';

class ApiManager {
  static const _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  final Client _client;

  ApiManager(this._client) {
    HttpOverrides.global = MyHttpOverrides();
  }

  final RetryOptions retryOptions = const RetryOptions(
    maxAttempts: AppConstants.maxRequestAttempts,
    delayFactor: Duration(milliseconds: AppConstants.delayFactor),
  );

  final int durationMilliseconds = AppConstants.durationMilliseconds;

  Future<ApiResponse> updateQuestionnaire(JsonMap jsonMap) async {
    final uri = Uri.http(AppConstants.questionnaireAuthority, AppConstants.updateQuestionnaireEndPoint);
    try {
      final body = json.encode(jsonMap);
      final response = await retryOptions.retry(
              () async => await _client
              .post(uri, headers: _headers, body: body)
              .timeout(Duration(milliseconds: durationMilliseconds)),
          retryIf: (error) => error is SocketException || error is TimeoutException);

      final responseMap = json.decode(response.body);

      final success = response.statusCode == 200 || response.statusCode == 201;
      return ApiResponse(success: success, data: responseMap);
    } on Exception catch (error) {
      return ApiResponse(success: false, data: {"error": error});
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 5
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
