import 'package:mobx/mobx.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Services/SettingService.dart';
import '../Model/Note.dart';
import '../Services/NoteService.dart';

part 'SettingObservable.g.dart';

class NoteObserver = _AbstractSettingObserver with _$NoteObserver;

abstract class _AbstractSettingObserver with Store {

  _AbstractSettingObserver(){
    SettingService.loadSetting().then((value) => initSettings(value));
  }

  @observable
  String currentScreen = "";

  @observable 
  Setting? userSettings; 


  @action
  void saveSetting(Setting? userSettings){
     //over-write old settings with incoming new one.
     if(userSettings != null){
       SettingService.save(userSettings);

       this.userSettings = userSettings;
     }
      
  }

  @action
  void initSettings(settings){
    print("Initialize settings : ${settings}");
    userSettings = settings;
  }

  @action
  void changeScreen(String name){
    print("Setting Screen changed to: "+ name);
    currentScreen = name;
  }
}

