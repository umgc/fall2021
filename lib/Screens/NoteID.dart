import 'package:uuid/uuid.dart';

String main() {
  var uuid = Uuid();



  // Generate a v4 (random) id
  var v4 = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

 return v4;
}