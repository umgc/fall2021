import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Screens/Note/Note.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:provider/provider.dart';

import 'Setting.dart';
import 'Note/Note.dart';
import 'HomeScreen.dart';
import 'NotificationScreen.dart';
import 'package:untitled3/Screens/Menu/Menu.dart';
import './Note/SaveNote.dart';
import 'package:untitled3/Screens/Menu/Trigger.dart';
import 'package:untitled3/Screens/Menu/Help.dart';
import 'package:untitled3/Screens/Menu/SyncToCloud.dart';
import 'package:untitled3/Screens/Menu/GeneralSettings.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import '../Utility/Constant.dart';
import '../Observables/ScreenNavigator.dart';

final mainScaffoldKey = GlobalKey<ScaffoldState>();

/// This is the stateful widget that the main application instantiates.
class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;
  MainNavObserver screenNav = MainNavObserver();

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

  void _setScreenName(String screenName) {
    screenNav.changeScreen(screenName);
  }

  void _setScreenNameByIndex(int index) {
    //TODO: make sure index is less than length of array

    List<String> screenNames = [
      I18n.of(context)!.menuScreenName,
      I18n.of(context)!.notesScreenName,
      I18n.of(context)!.notificationsScreenName,
      I18n.of(context)!.homeScreenName,
    ];

    _setScreenName(screenNames[index]);
  }

  Widget _changeScreen(String name, index) {
    if (name == I18n.of(context)!.settingScreenName) {
      return Setting();
    }
    if (name == I18n.of(context)!.notesScreenName) {
      print("Return " + name);
      return ViewNotes();
    }
    if (name == I18n.of(context)!.menuScreenName) {
      print("Return " + name);
      return Menu();
    }
    if (name == I18n.of(context)!.HelpScreen) {
      print("Return " + name);
      return Help();
    }
    if (name == I18n.of(context)!.SyncToCloudScreen) {
      print("Return " + name);
      return SyncToCloud();
    }
    if (name == I18n.of(context)!.GeneralSettingsScreen) {
      print("Return " + name);
      return GeneralSetting();
    }
    if (name == I18n.of(context)!.TriggerScreen) {
      print("Return " + name);
      return Trigger();
    }

    /**
     * TODO: Uncomment for calendar
     * if(name == AppLocalizations.of(context)!.calendarScreenName){
      return Calendar();
    }*/
    return _widgetOptions.elementAt(index);
  }

  // flag to control whether or not results are read
  bool readResults = false;

  // flag to indicate a voice search
  bool voiceSearch = false;

  // Search bar to insert in the app bar header
  late SearchBar searchBar;

  // voice helper service

  /// Value of search filter to be used in filtering search results
  String searchFilter = "";

  /// Search is submitted from search bar
  onSubmitted(value) {
    if (voiceSearch) {
      voiceSearch = false;
      readResults = true;
    }
    searchFilter = value;
    setState(() => mainScaffoldKey.currentState);
  }

  // Search has been cleared from search bar
  onCleared() {
    searchFilter = "";
  }

  _getSearchBar() {
    searchFilter = "";
    return new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: onCleared,
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
      title: Observer(
          builder: (_) => Text(
                '${screenNav.currentScreen}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              )),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<MenuObserver>(create: (_) => MenuObserver()),
          Provider<NoteObserver>(create: (_) => NoteObserver()),
          Provider<MainNavObserver>(create: (_) => MainNavObserver()),
        ],
        child: (Scaffold(
          appBar: buildAppBar(context),
          body: Center(
              child: Observer(
                  builder: (_) =>
                      _changeScreen(screenNav.currentScreen, _currentIndex))),
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
        )));
  }
}
