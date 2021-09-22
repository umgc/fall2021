import 'package:mobx/mobx.dart';
part 'ScreenNavigator.g.dart';
class ScreenNav = AbstractScreenNav with _$ScreenNav;

abstract class AbstractScreenNav with Store {

  @observable
  String currentScreen = "";

  @action
  void changeScreen(String name){
    print("Screen changed to: "+ name);
    currentScreen = name;
  }

}