import 'package:mobx/mobx.dart';
part 'OnboardObservable.g.dart';
class OnboardObserver = _AbstractOnboardObserver with _$OnboardObserver;

abstract class _AbstractOnboardObserver with Store {

  @observable
  int currentScreenIndex = 0;
  

  @action
  void moveToNextScreen(){
    currentScreenIndex = currentScreenIndex+1;
  }

  @action
  void moveToPrevScreen(){
    
    if(currentScreenIndex-1 < 0){
      return;
    }
    currentScreenIndex = currentScreenIndex-1;
  }

  @action
  void reset(){
    currentScreenIndex = 0;
  }

}