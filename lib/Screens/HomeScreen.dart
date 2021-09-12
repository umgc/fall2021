import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Services/Speech.dart';
import 'custom_animated_bottom_bar.dart';
import 'Setting.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final maxLines = 10;

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
          title: Text('Memory Magic',
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

        body: Speech(),
      bottomNavigationBar: BottomBar(3),

        );

  }
}
