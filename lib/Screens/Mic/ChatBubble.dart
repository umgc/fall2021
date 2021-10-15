
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';

class ChatMsgBubble extends StatelessWidget {
  final String? message;
  List<String>? actionOption;
  bool isSender;
  TextStyle textStyle;

  ChatMsgBubble({
    Key? key,
    @required this.message, 
    this.isSender = false,
    this.actionOption = const [],
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

                  if(actionOption!.length > 0)
                  
                  Wrap(        
                    alignment: WrapAlignment.spaceEvenly,            
                    children: [
                     for (var item in actionOption!)
                      Container(
                        margin: new EdgeInsets.symmetric(horizontal: 2.0),
                        child: ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: 100.0,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              //action
                            },
                            child: Text(item),
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