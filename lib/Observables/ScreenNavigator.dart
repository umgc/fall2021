import 'package:mobx/mobx.dart';
import 'package:untitled3/Utility/Constant.dart';
part 'ScreenNavigator.g.dart';
class MainNavObserver = _AbstractMainNavObserver with _$MainNavObserver;

abstract class _AbstractMainNavObserver with Store {

  @observable
  dynamic currentScreen = MAIN_SCREENS.HOME ;

  @observable
  String screenTitle ="";

  @observable
  dynamic focusedNavBtn = 0;

  @action
  void changeScreen(dynamic screen){
    currentScreen = screen;
    focusedNavBtn = -1;
  }

  @action
  void setTitle(String title){
    print("Screen changed to: "+ title);
    screenTitle = title;
    
  }

  @action
  void setFocusedBtn(dynamic focusedBtn){
    focusedNavBtn = focusedBtn;
  }

}