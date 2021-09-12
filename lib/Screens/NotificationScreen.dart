import 'package:flutter/material.dart';
import 'Setting.dart';
import 'custom_animated_bottom_bar.dart';

class NotificationScreen extends StatefulWidget {
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
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
        title: Text('Notification',
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
      bottomNavigationBar: BottomBar(2),
    );
  }
}
