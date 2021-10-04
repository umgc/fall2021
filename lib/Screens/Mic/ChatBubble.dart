
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';

class ChatMsgBubble extends StatelessWidget {
  final String? message;
  bool hasAction;
  bool isSender;
  TextStyle textStyle;

  ChatMsgBubble({
    Key? key,
    @required this.message, 
    this.isSender = false,
    this.hasAction= false,
    this.textStyle = const TextStyle(fontSize: 20),
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Column(
                children: [
                  BubbleSpecialOne(
                    text: '${(this.isSender)?'Me': 'System'}\n${this.message!}',
                    isSender: this.isSender, 
                    color: (this.isSender)?const Color(0xAFdbf2d5):const Color(0xAFa6ffd1),
                    textStyle: this.textStyle
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