
import 'dart:math' as math; // import this

import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Screens/Mic/CustomMsgShape.dart';

class ReceivedMessageScreen extends StatelessWidget {
  // final String? message;
  // const ReceivedMessageScreen({
  //   Key? key,
  //   @required this.message,
  // }) : super(key: key);
  bool hasAction = false;
  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Column(
                children: [
                  BubbleSpecialOne(
                    text: 'Would you like to save your note?',
                    isSender: false,
                    color: Color(0xAF52FF8C),
                    textStyle: TextStyle(fontSize: 20)
                  ),

                  if(hasAction)
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 20.0),
                        child: ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: 100.0,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                                //take action when pressed 
                            },
                            child: Text("yes"),
                          ),
                        ),
                      ),
                      Container(
                        child: ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: 100.0,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              //action
                            },
                            child: Text("No"),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );

    return  messageTextGroup;
  }
}