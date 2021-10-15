import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import '../Observables/ChecklistObservable.dart';

final ChecklistObserver checklistObserver = new ChecklistObserver();

class Checklist extends StatefulWidget {

  @override
  ChecklistState createState() => ChecklistState();
}

class ChecklistState extends State<Checklist> {


  @override

  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);

   String noteText="" ;
    bool isChecked = checklistObserver.IsChecked;
    Map<String, bool> checkListEvent ={
      /* 'Brush Teeth' : true,
      'Get Mail'    : isChecked,
      'Drink Water' : isChecked,
      'Make Dinner' : isChecked,*/

      noteText : isChecked

    };
    var checkListEvents=[];
     for (TextNote textNote in noteObserver.usersNotes) {
      if (textNote.text.toString() != "" && textNote.isCheckList) {

        noteText = textNote.text.toString();
        checkListEvents.add(noteText);

      }
    }


   /* for  (checkListEvent in checkListEvents) {
      for  (TextNote textNote in noteObserver.usersNotes) {
     // if (textNote.text.toString() != "" && textNote.isCheckList) {

        noteText = textNote.text.toString();
        checkListEvents.add(noteText);


      }
    }*/
  /*  getList(){
    checkListEvent.forEach((noteText, isChecked) {
      for  (TextNote textNote in noteObserver.usersNotes) {
        // if (textNote.text.toString() != "" && textNote.isCheckList) {

        noteText = textNote.text.toString();
        checkListEvents.add(noteText);

        /* if (isChecked == true)*/


  //  checkListEvents.add(noteText);
   }
    });
    }*/

return Column (children: <Widget>[
      Expanded(
        child :

        ListView(
          children: checkListEvent.keys.map(( key) {
            return new CheckboxListTile(
              title: Text(noteText),
              value:  checkListEvent[key],
              activeColor: Colors.white,
              checkColor: Colors.black,

              onChanged: (isChecked) {
                  if (isChecked == true){
                    checklistObserver.checked();
                  }
                  else{
                    checklistObserver.unChecked();
                  }
                 checkListEvent[key] = isChecked!;

              },
            );
          }).toList(),
        ),

      ),

    ]
    );
  }

}

