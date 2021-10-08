import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/NoteObservable.dart';

class Checklist extends StatefulWidget {

  @override
  ChecklistState createState() => ChecklistState();
}

class ChecklistState extends State<Checklist> {

  @override

  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    String noteText = "";
    for (TextNote textNote in noteObserver.usersNotes) {
      if (textNote.text.toString() != "") {
        noteText += textNote.text.toString();
      }
    }
    Map<String, bool> checkListEvent ={
      'Brush Teeth' :false,
     'Get Mail'    : false,
    'Drink Water' : false,
    'Make Dinner' : false,
      noteText :false

    };
    var checkListEvents=[];

    getList(){
    checkListEvent.forEach((key, value) {
    if (value == true)
    {
    checkListEvents.add(key);
    }
    });
    }
    return Column (children: <Widget>[

      Expanded(
        child :
        ListView(
          children: checkListEvent.keys.map(( key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: checkListEvent[key],
              activeColor: Colors.white,
              checkColor: Colors.white,
              onChanged: ( isChecked) {
                setState(() {
                    checkListEvent[key] = false ;
                });
              },
            );
          }).toList(),
        ),
      ),]);
  }
}
