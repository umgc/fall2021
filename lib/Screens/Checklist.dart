import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/CheckListObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';

class Checklist extends StatefulWidget {
  @override
  ChecklistState createState() => ChecklistState();
}

class ChecklistState extends State<Checklist> {
  @override
  Widget build(BuildContext context) {
    final checkListObserver = Provider.of<CheckListObserver>(context);
    final noteObserver = Provider.of<NoteObserver>(context);
    checkListObserver.setNotObserver(noteObserver);

    String todaysDate = DateTime.now().toString().split(" ")[0];
    checkListObserver.getDailyCheckList(todaysDate);

    print(
        "checkListObserver.dailyCheckList ${checkListObserver.dailyCheckList.length}");
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: checkListObserver.dailyCheckList.keys.map((key) {
            print("good");
            return new CheckboxListTile(
              title: new Text(key.text),
              value: checkListObserver.dailyCheckList[key],
              activeColor: Colors.white,
              checkColor: Colors.white,
              onChanged: (isChecked) {
                checkListObserver.addToCheckedItems(key);
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
