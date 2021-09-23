import 'package:flutter/material.dart';
import 'package:untitled3/Screens/Note.dart';
import 'package:untitled3/generated/i18n.dart';
import 'Setting.dart';
import 'Note.dart';
import 'HomeScreen.dart';
import 'NotificationScreen.dart';
import 'Menu.dart';

/// This is the stateful widget that the main application instantiates.
class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends  State<MainNavigator> {
  int _currentIndex =0;
  String _screenName = "";

  static List<Widget> _widgetOptions = <Widget>[
    Menu(),

    ViewNotes(),

    NotificationScreen(),

    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    _setScreenNameByIndex(index);
    setState(() {
      _currentIndex = index;
    });
  }

  void _setScreenName(String name) {
    setState(() {
      _screenName = name;
    });
  }

  void _setScreenNameByIndex(int index) {
    //TODO: make sure index is less than length of array

    List <String> screenNames = [
      I18n.of(context)!.menuScreenName,
      I18n.of(context)!.notesScreenName,
      I18n.of(context)!.notificationsScreenName,
      I18n.of(context)!.homeScreenName,
    ];

    _setScreenName(screenNames[index]);
  }

  Widget _pickScreen(String name, index){

    if(name == I18n.of(context)!.settingScreenName){
      return Setting();
    }
    /**
     * TODO: Uncomment for calendar
     * if(name == AppLocalizations.of(context)!.calendarScreenName){
      return Calendar();
    }*/

    return _widgetOptions.elementAt(index);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          leading: IconButton(

              onPressed: () {
                _setScreenName(I18n.of(context)!.settingScreenName);
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 35,
              )),
          toolbarHeight: 90,
          title: Text(_screenName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black)),
          backgroundColor: Color(0xFF33ACE3),
          centerTitle: true,
          actions: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      //_setScreenName(SCREEN_NAMES.CALENDAR);
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

      body:Center(
        child: _pickScreen(_screenName, _currentIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        backgroundColor: Color(0xFF33ACE3),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 40,
            ),
            label: I18n.of(context)!.menuScreenName,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note_sharp,
              size: 40,
            ),
            label: I18n.of(context)!.notesScreenName,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 40,
            ),
            label: I18n.of(context)!.notificationsScreenName,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/mic.png",
              width: 51.84,
              height: 46,
            ),
            label: I18n.of(context)!.micButton,
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
