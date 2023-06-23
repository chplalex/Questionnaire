import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:questionnaire/app/app_constants.dart';
import 'package:retry/retry.dart';

import '../../app/app_typedefs.dart';
import '../models/api_response.dart';

class ApiManager {
  static const errorKey = "error";

  static const _headers = {
    "Accept": "*/*",
    "Content-Type": "application/json",
  };

  static const _retryOptions = RetryOptions(
    maxAttempts: AppConstants.apiMaxRequestAttempts,
    delayFactor: AppConstants.apiRetryDelayFactorDuration,
  );

  final Client _client;

  const ApiManager(this._client);

  Future<ApiResponse> updateQuestionnaire(JsonMap jsonMap) async {
    final authority = AppConstants.questionnairePort.isEmpty
        ? AppConstants.questionnaireAuthority
        : "${AppConstants.questionnaireAuthority}:${AppConstants.questionnairePort}";
    final uri = Uri.http(authority, AppConstants.updateQuestionnaireEndPoint);

    debugPrint("Make API call: $uri");

    try {
      final body = json.encode(jsonMap);
      final response = await _retryOptions.retry(
        () => _client
            .post(
              uri,
              headers: _headers,
              body: body,
            )
            .timeout(
              AppConstants.connectionTimeoutDuration,
            ),
        retryIf: (error) {
          return error is SocketException || error is TimeoutException;
        },
      );
      final responseMap = json.decode(response.body);
      final success = response.statusCode == 200 || response.statusCode == 201;
      return ApiResponse(success: success, data: responseMap);
    } on Exception catch (error) {
      return ApiResponse(success: false, data: {errorKey: error.toString()});
    }
  }
}
