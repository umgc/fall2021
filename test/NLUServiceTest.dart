import 'package:flutter_test/flutter_test.dart';
import '../lib/Services/NLU/Bot/NLULibService.dart';

void main() async {
  try {
    final nluService = NLULibService();
    await nluService.process('Make a car reservation');
  } catch (error) {
    print('Error occured during division: $error');
  }
}