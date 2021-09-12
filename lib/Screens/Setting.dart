import 'package:flutter/material.dart';
import 'custom_animated_bottom_bar.dart';
class Setting extends StatefulWidget {

  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(

            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Setting()),);
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 35,
            )),
        toolbarHeight: 90,
        title: Text('Setting',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black)),
        backgroundColor: Color(0xFF33ACE3),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(

                  onPressed: (){},
                  icon: Icon(
                    Icons.event_note_sharp,
                    color: Colors.white,
                    size: 35,
                  ))
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomBar(0),
    );
  }
}
