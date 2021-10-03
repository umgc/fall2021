import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:reading_time/reading_time.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
part 'MicObservable.g.dart';

class MicObserver = _AbstractMicObserver with _$MicObserver;

abstract class _AbstractMicObserver with Store {

 List<dynamic> mockedInteraction = ["Please remind me to go to the market tomorrow",
    NLUResponse(ActionType.InComplete, "Please remind me to go to the market tomorrow", "Sure I will. Is there anything else I can help you with?"),
   "No. Thank you",
    NLUResponse(ActionType.Complete, "Thank you", "Thank you")
   ];

  //remove this.
  @observable
  int mockIndex = 0;

  //messageInputText will be initialize and read and then its content will be added to the systemUserMessage to be displayed in the chat bubble.
  @observable
  String messageInputText = ""; 

  @observable
  ObservableList<dynamic> systemUserMessage = ObservableList();

  @observable
  NLUResponse? nluResponse;

  @action
  void addUserMessage(String name){
    systemUserMessage.add(name);
  }

  @action
  void addSystemMessage(NLUResponse name){
    systemUserMessage.add(name);
  }

  @action 
  void fufillTask(NLUResponse name){
    //Save notes
    //Go to help screeen
    //Navigate to another screen
    //etc.
  }

  @action
  void clearMsgTextInput(){
    messageInputText = "";
  }

  @action 
  void callNLU(String speechText){
      print(" $mockIndex Calling NLU with speechText $speechText");
      //call NLU service
      nluResponse = (mockedInteraction[mockIndex] as NLUResponse);
      //set as MessageInputText 
      setMessageInputText(nluResponse, true);

      mockIndex++;
  }

  @action 
  void setMessageInputText(dynamic value, bool isSysrMsg){
      //push prev message to chartBubble 
      if(isSysrMsg==true){
           VoiceOverTextService.speakOutLoud( (value as NLUResponse).outputText );
           messageInputText = (value as NLUResponse).outputText;
           Timer(Duration(seconds: (readingTime(messageInputText).minutes as int) ), () {
                addSystemMessage( (value as NLUResponse) );              
          });

      }else{
          print("adding a user message $value");
          messageInputText =value;

           Timer(Duration(seconds: 1), () {
              addUserMessage(value);
          });
          
      }
  }

  @action
  void mockInteraction(){
      if(mockIndex >= mockedInteraction.length){
        clearMsgTextInput();
        return;
      }
      Timer(Duration(seconds: 2), () {
        print("mockIndex $mockIndex");
        setMessageInputText(mockedInteraction[mockIndex], false);
        mockIndex = mockIndex+1;

        Timer(Duration(seconds: 2), () {
          callNLU(messageInputText);

          Timer(Duration(seconds: 2), () {
              mockInteraction();
           });
        });
      });

  }
}
