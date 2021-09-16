import 'package:flutter/material.dart';
import 'Setting.dart';
import 'Bottom_bar.dart';

class Menu extends StatefulWidget {

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {

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
        title: Text('Menu',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black)),
        backgroundColor: Color(0xFF33ACE3),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {


                  },
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
