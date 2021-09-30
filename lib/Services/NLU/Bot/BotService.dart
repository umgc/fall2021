import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../BertQA/BertQaService.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';

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

  ///The base class for [AmazonLex].
  ///
  ///Create a local instance to use.
  ///Note that this defaults to us-east-1 as the region.
  class BotService {
    late Map<String, dynamic> result;
    String botName = "BookAppointment";
    String kAccessKeyId = 'ASIAZWJRDCYYKA6INEEW';
    String kSecretAccessKey = 'kZqma4VZie1awlEqLPgVOQzVl2qiQOV+WJH86zwR';
    String sessionToken = 'IQoJb3JpZ2luX2VjEDoaCXVzLWVhc3QtMiJIMEYCIQDQh4gelDqno96q39RwiPT5x7K7SyVOSmeDpUMd9SthWAIhAP5tT81Cb+Rb2zN85delmYB4KECmW1uL7Tr36C/M2GaJKr0DCKP//////////wEQARoMNjY2MzU5NzY0NTI4Igyu9F2yAqZN3dG0q9YqkQMVrg/4mCJjDxg0QmplU581Z2P8LGhGfr9vgei6SaONhhfks5Kt9Ikbh61G9UiQ3SXgPLbHjOfTUueaIIcBz1Y3LcW+WajtfsGfB8CqT76lkJLtkvl+1KjSCVn6k+/K/iWgr3Zc1Ej+qT2djTH4x1OWFNS6i6iCtlUy/Z6i3P2fziHGsEmafkH3ict+07dFb3DA2aRnUhnaCHfQDNd/5ub70oILwB4UgtgGNkbM9SE/NxKgPZY9qIktYifqcgfDyYMYHlvY9XEc0UT2jfaQKDYVgMCdsdsW5mkoBYzLRisQhKxjfwaBpkRtdW8dEHFAG04eV4JSAbOSat3bgUwahATGizOdsMz/qhnS9qzShQGgSR6OU6pDDUtuHCGh0sgwrjsZ+bGDfzkw5Sy3JhjQpozfinCsAmDZ1t3nX6llw9OR9B2mdDHCeccsWGwjIvmprs21FtgjDuKGzaAET6HgQAR+pkFUgxBWVmZArtck1ziG21FEN8pFR75rOgxSkQ3yEZeDZkIIZ/aJnABGvbC3Fbq9ATD6ycuKBjqlAaGPeFKzdCR1dBh4sHQVHejXNegWWZV72n4MLyZx2FE9wLUfPGXXW+pYZg4SySvN0Z4OnGoYdlO/pjKvdRa507mSD8N8EhkwgpJMatFobJb0hsz7GY5flutVSkDfBDYkU91vpl7YCJ5rlvuR0I6iWe+K7smYj5hzm16YokWsRQ4EeWHo0peEJuqTZrZt/U4gHVsFpG44V8Yb6iRdZL78E+5xcgjeFw==';
    String botAlias = "BookAppointmentDeployment";
    String botAWSRegion = "us-east-1";
    late final BertQAService bertQAService;
    String url = 'https://runtime.lex.us-east-1.amazonaws.com';
    String serviceName = 'lex';

    BotService() {
      bertQAService = BertQAService();
    }

    String userId = 'testuser123';

    Future<Map<String, dynamic>> callBot(String message) async {
      var response;
      // searchNotes(message);
      AwsSigV4Client client = AwsSigV4Client(
        kAccessKeyId,
        kSecretAccessKey,
        'https://runtime.lex.us-east-1.amazonaws.com',
        region: 'us-east-1',
        serviceName: 'lex',
        sessionToken: sessionToken
      );

      final signedRequest = new SigV4Request(
        client,
        method: 'POST',
        path: '/bot/$botName/alias/$botAlias/user/MyUser/text',
        headers: new Map.from({
          'Content-Type': 'application/json; charset=utf-8',
          'ACCEPT': 'application/json',
        }),
        body: new Map<String, dynamic>.from({"inputText": message}),
      );


      String contentTypeValue = "{Content-Type : application/json; charset=utf-8,"
        "ACCEPT : application/json}";

      Uri botUri = Uri.parse(signedRequest.url.toString());
      Map<String, String>? mapHeader = json.decode(contentTypeValue);
      response = await http.post(
        botUri,
        headers: mapHeader,
        body: signedRequest.body,
      );
      result = jsonDecode(response.body);
      return result;
    }

    String searchNotes(String message) {
      // ToDo Get Notes
      String answer = bertQAService
          .answer(
          "I have a toothache. 4 more popcorns on the couch. I had an appointment with "
              "dentist on monday oct 5th at 9 am. My wife blood pressure is 138."
              " My blood pressure is 140 above. I need to pick up 3 candies from the store. "
              " I have a dinner on octobher 5, Raj, DJ and my dear rohan and riya are coming.",
          message)
          .first
          .text;
      return answer;
    }
  }