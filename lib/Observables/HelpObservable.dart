import 'package:mobx/mobx.dart';
import 'package:untitled3/Model/Help.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Services/HelpService.dart';
import 'package:untitled3/Services/NoteService.dart';
part 'HelpObservable.g.dart';

class HelpObserver = _AbstractHelpObserver with _$HelpObserver;

abstract class _AbstractHelpObserver with Store {

  @observable
  List<HelpContent>  helpItems = [];

  _AbstractHelpObserver(){
    // HelpContent help = HelpContent();
    // help.title = "How to create note by voice";
    // help.videoUrl = "url";
    // helpItems.add(help);
    loadHelpCotent();
  }

  @action
  Future<void> loadHelpCotent() async {
    print("Loading help content");
    helpItems = await HelpService.loadHelpContent();
    print("loadHelpCotent helpItems.length ${helpItems.length}");
    print("loadHelpCotent helpItems ${helpItems}");
  }

}
