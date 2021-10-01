library LexService;

import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/Services/NoteService.dart';

///The different types of responses a [LexResponse] can be
enum DialogState {
  ElicitIntent,
  ConfirmIntent,
  ElicitSlot,
  Fulfilled,
  ReadyForFulfillment,
  Failed,
}

enum MessageFormat { PlainText, CustomPayload, SSML, Composite }

///The base class for [LexService].
///
///Create a local instance to use.
class LexService {
  late String _accessKey;
  late String _secretKey;
  late String _url;
  late String _region;
  late String _serviceName;
  late String _botId;
  late String _botAliasId;
  late String _localeId;

  LexService() {
    this._url = 'https://runtime-v2-lex.us-west-2.amazonaws.com';
    this._region = 'us-west-2';
    this._serviceName = 'lex';
    this._accessKey = 'AKIAYHE3SPHSCGFUDEGD';
    this._secretKey = '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';
    this._botId = 'KCQ0L420SM';
    this._botAliasId = 'TSTALIASID';
    this._localeId = 'en_US';
  }

  Future<Map<String, dynamic>> getLexResponse({
    @required String? text,
    ///[userId] is the unique ID for the current user/session/etc
    ///This can be fixed, generated randomly, or taken from a known source.
    required String userId,
    required String locale
  }) async {
    Map<String, dynamic> value = new Map();
    try {
      assert(text != null);
      String lexResponse = "";
      Map<String, String>? mapHeader = Map<String, String>.from({
        'Content-Type': 'application/json; charset=utf-8',
      });
      AwsSigV4Client client = AwsSigV4Client(
          _accessKey,
          _secretKey,
          _url,
          region: _region,
          serviceName: _serviceName);
      final signedRequest = SigV4Request(
        client,
        method: 'POST',
        path: '/bots/$_botId/botAliases/$_botAliasId/botLocales/$_localeId/sessions/$userId/text',
        headers: mapHeader,
        body: Map<String, dynamic>.from({"text": text}),
      );
      Uri uri = Uri.parse(signedRequest.url.toString());
      // {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      String? body = signedRequest.body;
      final response = await http.post(
        uri,
        headers: mapHeader,
        body: body,
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        value = json.decode(response.body);
        //return LexResponse.fromJson(value);
      }
    } catch (error) {
      print('Error occured during division: $error');
    }
    return value;
  }
}