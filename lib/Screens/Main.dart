import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled3/Screens/Note.dart';
import 'Setting.dart';
import 'Note.dart';
import 'HomeScreen.dart';
import 'NotificationScreen.dart';
import 'Menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../Utility/Constant.dart';
import '../Observables/ScreenNavigator.dart';

/// This is the stateful widget that the main application instantiates.
class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends  State<MainNavigator> {
  int _currentIndex =0;
  String _screenName = "";
  ScreenNav screenNav = ScreenNav();

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

  void _setScreenName(String screenName){
    screenNav.changeScreen(screenName);
  }
  void _setScreenNameByIndex(int index) {
    //TODO: make sure index is less than length of array

    List <String> screenNames = [
      AppLocalizations.of(context)!.menuScreenName,
      AppLocalizations.of(context)!.notesScreenName,
      AppLocalizations.of(context)!.notificationsScreenName,
      AppLocalizations.of(context)!.homeScreenName,
    ];

    _setScreenName(screenNames[index]);
  }

  Widget _changeScreen(String name, index){
    print("Return "+name);

    if(name == SCREEN_NAMES.SETTING){
      print("Return "+name);
      return Setting();
    }
    /**
     * TODO: Uncomment for calendar
     * if(name == SCREEN_NAMES.CALENDAR){
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
                _setScreenName(SCREEN_NAMES.SETTING);
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 35,
              )),
          toolbarHeight: 90,
          title: Observer(
              builder: (_) => Text(
                '${screenNav.currentScreen}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black),
              )
          ),
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
        child: Observer(
            builder: (_) => _changeScreen(screenNav.currentScreen, _currentIndex)
        )
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
