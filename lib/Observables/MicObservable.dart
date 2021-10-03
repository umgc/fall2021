import 'package:mobx/mobx.dart';
import 'package:untitled3/Model/LexResponse.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
part 'MicObservable.g.dart';

class MicObserver = _AbstractMicObserver with _$MicObserver;

abstract class _AbstractMicObserver with Store {

 List<dynamic> mockedInteraction = ["Please remind me to go to the market tomorrow",
    NLUResponse(ActionType.InComplete, "Please remind me to go to the market tomorrow", "Sure I will. Is there anything else I can help you with"),
   "No. Thank you",
    NLUResponse(ActionType.Complete, "Thank you", "Thank you")
   ];

  //messageInputText will be initialize and read and then its content will be added to the systemUserMessage to be displayed in the chat bubble.
  @observable
  String messageInputText = ""; 

  @observable
  List<dynamic> systemUserMessage = [];

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
  void displayMessageInMessageInput(){

  }

  @action 
  void setMessageInputText(String value){
      this.messageInputText = value;
  }
}
