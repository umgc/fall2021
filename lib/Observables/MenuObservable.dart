import 'package:mobx/mobx.dart';
part 'MenuObservable.g.dart';

class MenuObserver = _AbstractMenuObserver with _$MenuObserver;

abstract class _AbstractMenuObserver with Store {

  @observable
  String currentScreen = "";

  @action
  void changeScreen(String name){
    print("Note Screen changed to: "+ name);
    currentScreen = name;
  }

}
