import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  //String dropDownValue1 = 'Delete Notes after 14 Days';
  //String dropDownValue2 = 'Delete Notes after 14 Days';
  //String dropDownValue3 = 'Delete Notes after 14 Days';
  String dropDownValue4 = 'English';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var deleteNotes;
  List<String> notes = [
    "Delete Notes after 14 Days",
    "Delete Notes after 7 Days",
    "Delete Notes after 5 Days",
    "Delete Notes after 3 Days",
    "Delete Notes after 1 Day",
  ];
  var fontNotes;
  List<String> fontN = [
    "Small Sized Font",
    "Medium Sized Font",
    "Large Sized Font",
    "Extra Large Sized Font",
  ];
  var fontMenu;
  List<String> fontM = [
    "Small Sized Font",
    "Medium Sized Font",
    "Large Sized Font",
    "Extra Large Sized Font",
  ];
  var language;
  List<String> lang = [
    "English",
    "Arabic",
    "Chinese (Simplified)",
    "French",
    "Hindi",
    "Portuguese",
    "Spanish",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.0),
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
            Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
            child: Container(
              width: 60,
              height: 40,
              padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: DropdownButton(
                hint: Text(
                  "Select Notes Deletion Timeline",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                icon: Icon(                // Add this
                  Icons.edit_sharp,  // Add this
                  color: Colors.blue,   // Add this
                ),
                value: deleteNotes,
                onChanged: (newValue) {
                  setState(() {
                    deleteNotes = newValue;
                  });
                },
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 22),
                items: notes.map((valueItem) {
                  return DropdownMenuItem(
                      value: valueItem, child: Text((valueItem)));
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
            child: Container(
              width: 60,
              height: 40,
              padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: DropdownButton(
                hint: Text(
                  "Select Font Size for Notes",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                icon: Icon(                // Add this
                  Icons.edit_sharp,  // Add this
                  color: Colors.blue,   // Add this
                ),
                value: fontNotes,
                onChanged: (newValue) {
                  setState(() {
                    fontNotes = newValue;
                  });
                },
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 22),
                items: fontN.map((valueItem) {
                  return DropdownMenuItem(
                      value: valueItem, child: Text((valueItem)));
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
            child: Container(
              width: 60,
              height: 40,
              padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: DropdownButton(
                hint: Text(
                  "Select Font Size for Menu",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                icon: Icon(                // Add this
                  Icons.edit_sharp,  // Add this
                  color: Colors.blue,   // Add this
                ),
                value: fontMenu,
                onChanged: (newValue) {
                  setState(() {
                    fontMenu = newValue;
                  });
                },
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 22),
                items: fontM.map((valueItem) {
                  return DropdownMenuItem(
                      value: valueItem, child: Text((valueItem)));
                }).toList(),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(1.0, 22.0, 3.0, 4.0),
            child: Text('Language',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              width: 60,
              height: 40,
              padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: DropdownButton(

                hint: Text(
                  "Select Language",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                //icon: Icon(                // Add this
                //  Icons.arrow_drop_down_outlined,  // Add this
                //  color: Colors.blue,   // Add this
                //),
                icon: Image.asset(                // Add this
                  //Icons.arrow_drop_down_outlined, //size: 38.0,  // Add this
                  "assets/images/dropdownarrow.png",
                  width: 28,
                  height: 18,
                  //Icons.arrow_drop_down_outlined,
                  //size: 31,
                  color: Colors.blue,   // Add this
                ),
                value: language,
                onChanged: (newValue) {
                  setState(() {
                    language = newValue;
                  });
                },
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 22),
                items: lang.map((valueItem) {
                  return DropdownMenuItem(
                      value: valueItem, child: Text((valueItem)));
                }).toList(),
              ),
            ),
          ),

          //SAVE BUTTON
          Container(
            padding:
            const EdgeInsets.only(left: 0, top: 22, right: 0, bottom: 0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Save", style: TextStyle(fontSize: 22),),

              style: ElevatedButton.styleFrom(
                  fixedSize: Size(30, 40), primary: Colors.lightBlue, onPrimary: Colors.black),
            ),
          ),

          //RESET BUTTON//
          Container(
            padding:
            const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Reset Settings", style: TextStyle(fontSize: 22),),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(30, 40), primary: Colors.lightBlue, onPrimary: Colors.black),
            ),
          ),

          //SECURITY BUTTON
          Container(
            padding:
            const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Security Settings", style: TextStyle(fontSize: 22),),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(30, 40), primary: Colors.lightBlue, onPrimary: Colors.black),
            ),
          ),

          //CANCEL BUTTON
          Container(
            padding:
            const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Cancel", style: TextStyle(fontSize: 22),),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(30, 40), primary: Colors.grey),
            ),
          )
        ]),
      ),
    );
  }
}
