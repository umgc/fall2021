import 'package:mobx/mobx.dart';
part 'ScreenNavigator.g.dart';
class MainNavObserver = _AbstractMainNavObserver with _$MainNavObserver;

abstract class _AbstractMainNavObserver with Store {

  @observable
  String currentScreen = "";

  @action
  void changeScreen(String name){
    print("Screen changed to: "+ name);
    currentScreen = name;
  }

}