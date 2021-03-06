import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/network/rest_apis.dart';
import 'package:streamit_flutter/screens/signin.dart';
import 'package:streamit_flutter/utils/constants.dart';

enum ResponseType { FULL_RESPONSE, JSON_RESPONSE, BODY_BYTES, STRING_RESPONSE }

Future<Map<String, String>> buildTokenHeader({bool isPlainTextContent = false, bool aAuthRequired = true}) async {
  String token = await getString(TOKEN);

  Map<String, String> header;

  if (isPlainTextContent) {
    header = {"Accept": "text/plain"};
  } else {
    header = {'Content-Type': "application/json"};
  }
  if (aAuthRequired && token.isNotEmpty) {
    header.putIfAbsent('Authorization', () => 'Bearer $token');
  }

  log(jsonEncode(header));
  return header;
}

Future<Response> postRequest(String endPoint, Map body, {bool aAuthRequired = true}) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }
  try {
    String url = '$mBaseUrl$endPoint';
    log('POST: $url');
    log('Request: $body');

    Map<String, String> headers = await buildTokenHeader(aAuthRequired: aAuthRequired);
    Response response = await post(url, body: jsonEncode(body), headers: headers);

    log('POST: $url');
    log('Request: $body');

    if (response.body != null) {
      log('Status: ${response.statusCode} ${response.body}');
    } else {
      log('Status: ${response.statusCode}: null');
    }
    log('----');
    return response;
  } catch (e) {
    log('Error: $e');
    throw e;
  }
}

Future<Response> getRequest(String endPoint, {bool aAuthRequired = true}) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }
  try {
    String url = '$mBaseUrl$endPoint';
    log('GET: $url');

    Map<String, String> headers = await buildTokenHeader(aAuthRequired: aAuthRequired);
    Response response = await get(url, headers: headers);

    log('GET: $url');
    if (response.body != null) {
      log('Status: ${response.statusCode} ${response.body}');
    } else {
      log('Status: ${response.statusCode}: null');
    }
    log('----');
    return response;
  } catch (e) {
    log('Error: $e');
    throw e;
  }
}

Future<Response> deleteRequest(String endPoint, {bool aAuthRequired = true}) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }
  try {
    var url = '$mBaseUrl$endPoint';
    log('DELETE: $url');

    Map<String, String> headers = await buildTokenHeader(aAuthRequired: aAuthRequired);
    Response response = await delete(url, headers: headers);

    log('DELETE: $url');
    if (response.body != null) {
      log('Status: ${response.statusCode} ${response.body}');
    } else {
      log('Status: ${response.statusCode}: null');
    }
    log('----');
    return response;
  } catch (e) {
    log('Error: $e');
    throw e;
  }
}

Future handleResponse(Response response, {ResponseType responseType = ResponseType.JSON_RESPONSE}) async {
  if (response.statusCode.isSuccessful()) {
    if (responseType == ResponseType.JSON_RESPONSE) {
      return jsonDecode(response.body);
    } else if (responseType == ResponseType.FULL_RESPONSE) {
      return response;
    } else if (responseType == ResponseType.STRING_RESPONSE) {
      return response.body;
    } else if (responseType == ResponseType.BODY_BYTES) {
      return response.bodyBytes;
    } else {
      return '';
    }
  } else {
    if (!await isNetworkAvailable()) {
      throw errorInternetNotAvailable;
    } else if (response.statusCode == 401) {
      await refreshToken(aReloadApp: true);
    } else if (response.body.isJson()) {
      Map<String, dynamic> json = jsonDecode(response.body);

      if (json.containsKey(msg)) {
        throw json[msg];
      } else {
        throw errorSomethingWentWrong;
      }
    } else {
      throw errorSomethingWentWrong;
    }
  }
}

Future<MultipartRequest> getMultiPartRequest(String endPoint) async {
  String url = '$mBaseUrl$endPoint';
  return MultipartRequest('POST', Uri.parse(url));
}

Future sendMultiPartRequest(MultipartRequest multiPartRequest) async {
  await multiPartRequest.send().then((res) {
    log(res.statusCode);

    return res.stream.transform(utf8.decoder).listen((value) {
      log(jsonDecode(value));
      return jsonDecode(value);
    });
  }).catchError((error) {
    log(error);
    throw error;
  });
}

Future<void> refreshToken({bool aReloadApp, BuildContext context}) async {
  log('Refreshing Token $aReloadApp');

  var request = {
    "username": await getString(USER_EMAIL),
    "password": await getString(PASSWORD),
  };
  await token(request).then((res) async {
    log('New token saved');
    if (aReloadApp != null) {
      //
    } else {
      //
    }
  }).catchError((error) {
    log(error);
    if (context != null) {
      SignInScreen().launch(context);
    } else {
      //
    }
  });
}
