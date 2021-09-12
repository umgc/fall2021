import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Setting.dart';
import 'HomeScreen.dart';
import 'NotificationScreen.dart';
import 'Notes.dart';
import 'Menu.dart';
import 'Home.dart';

class BottomBar extends StatelessWidget {
  int _currentIndex;

  BottomBar(this._currentIndex);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xFF33ACE3),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (val) {
          if (val == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Menu()),
            );
          } else if (val == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notes()),
            );
          } else if (val == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          } else if (val == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 40,
            ),
            title: Text('Menu'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note_sharp,
              size: 40,
            ),
            title: Text('Notes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 40,
            ),
            title: Text('Notification'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/mic.png",
              width: 51.84,
              height: 46,
            ),
            title: Text('Mic'),
            activeIcon: Image.asset(
              "assets/images/mic.png",
              width: 51.84,
              height: 46,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
