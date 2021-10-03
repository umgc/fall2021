
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'CustomMsgShape.dart';
import 'dart:math' as math; // import this


class SentMessageScreen extends StatelessWidget {
  //final String? message;
  // const SentMessageScreen({
  //   Key? key,
  //   @required this.message,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
                    
                
    return BubbleSpecialOne(
                    text: 'I need help',
                    isSender: true,
                    color: Color(0xB0E2DD8C),
                    textStyle: TextStyle(fontSize: 20)
                  );
  }
}