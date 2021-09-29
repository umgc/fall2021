import 'package:flutter/material.dart';
import '../Observables/ScreenNavigator.dart';
import 'Main.dart';

class Checklist extends StatefulWidget {

  @override
  ChecklistState createState() => ChecklistState();
}

class ChecklistState extends State<Checklist> {
 /*List<Map> checklistEvents =[
   {"time": '02:00 PM', "task": "Check Mail", "isChecked": false},
   {"time": '09:00 AM', "task": "Brush Teeth", "isChecked": false},
 ];
*/

  Map<String, bool> checkListEvent ={
    'Brush Teeth' :false,
    'Get Mail'    : false,
    'Drink Water' : false,
    'Make Dinner' : false,

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

  @override

  Widget build(BuildContext context) {
    return Column (children: <Widget>[

      Expanded(
        child :
        ListView(
          children: checkListEvent.keys.map((String key) {
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
