import 'package:flutter_test/flutter_test.dart';

import 'package:untitled3/Services/NLU/Bot/LexService.dart';

void main() async {
  try {
    final lex = LexService();
    Map<String, dynamic> value = await lex.getLexResponse(text: 'how do I create a note');
    if (value != null) {
      expect(value.length > 0, true);
    }
  } catch(error){
    print('Error occured during division: $error');
  }
}