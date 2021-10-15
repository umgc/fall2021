import 'package:mobx/mobx.dart';
part 'ChecklistObservable.g.dart';

class ChecklistObserver = _AbstractChecklistObserver with _$ChecklistObserver;
abstract class _AbstractChecklistObserver with Store{
  @observable

  bool IsChecked= false;

  @action

  void checked(){

     IsChecked = true;
  }
  @action
  void unChecked(){
    IsChecked = false;
  }
}