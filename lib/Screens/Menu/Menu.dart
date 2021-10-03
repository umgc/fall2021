import 'package:flutter/material.dart';
import '../../Observables/MenuObservable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Utility/Constant.dart';
import 'package:untitled3/Screens/Settings/Trigger.dart';
import 'package:untitled3/Screens/Settings/Help.dart';
import 'package:untitled3/Screens/Settings/SyncToCloud.dart';
import 'package:untitled3/Screens/Settings/GeneralSettings.dart';





class Menu extends StatefulWidget {

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {


  @override
  Widget build(BuildContext context) {
    final menuObserver = Provider.of<MenuObserver>(context);
    menuObserver.changeScreen(SCREEN_NAMES.MENU);
    return
      Observer(
        builder: (_)
    =>
    (menuObserver.currentScreen.toUpperCase() == SCREEN_NAMES.MENU) ?
    Scaffold(
      body: Column(

        children: <Widget>[

          Column(
              children: [

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20),
                      height: 220,
                      width: 174,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            onPrimary: Colors.white,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            minimumSize: Size(40, 40)),
                        onPressed: () {
                          menuObserver.changeScreen(SCREEN_NAMES.SYNC_TO_CLOUD);

                        },
                        child: Column(children: [

                          Image(
                            image: AssetImage("assets/images/Cloud.png"),
                            color: Colors.white,
                            height: 150,
                            width: 155,
                          ),
                          Text('Sync to Cloud',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black))
                        ]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0, right: 20.0, top: 20),
                      height: 220,
                      width: 174,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            onPrimary: Colors.white,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            minimumSize: Size(10, 10)),
                        onPressed: () {
                          menuObserver.changeScreen(SCREEN_NAMES.TRIGGER);

                        },
                        child: Column(children: [
                          Padding(
                            padding: new EdgeInsets.all(5.0),
                          ),
                          Image(
                            image: AssetImage("assets/images/Trigger.png"),
                            color: Colors.white,
                            height: 140,
                            width: 155,
                          ),

                          Text('Trigger',

                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ))
                        ]),
                      ),
                    ),

                  ],
                )
              ]),
          Column(
              children: [

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20),
                      height: 220,
                      width: 174,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            onPrimary: Colors.white,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            minimumSize: Size(10, 10)),
                        onPressed: () {
                          menuObserver.changeScreen(SCREEN_NAMES.GENERAL_SETTING);

                        },
                        child: Column(children: [
                          Padding(
                            padding: new EdgeInsets.all(10.0),
                          ),
                          Image(
                            image: AssetImage("assets/images/Setting.png"),
                            color: Colors.white,
                            height: 132,
                            width: 132,
                          ),
                          Padding(
                            padding: new EdgeInsets.all(10.0),
                          ),
                          Text('General Setting',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black))
                        ]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0, right: 20.0, top: 20),
                      height: 220,
                      width: 174,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            onPrimary: Colors.white,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            minimumSize: Size(10, 10)),
                        onPressed: () {
                          menuObserver.changeScreen(SCREEN_NAMES.HELP);
                        },
                        child: Column(children: [
                          Padding(
                            padding: new EdgeInsets.all(5.0),
                          ),
                          Image(
                            image: AssetImage("assets/images/Help.png"),
                            color: Colors.white,
                            height: 150,
                            width: 155,
                          ),
                          Padding(
                            padding: new EdgeInsets.all(6.0),
                          ),
                          Text('Help',

                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ))
                        ]),
                      ),
                    ),

                  ],
                )
              ]),
        ],
      ),
    )
        : (menuObserver.currentScreen == SCREEN_NAMES.TRIGGER)
        ? Trigger()
        : (menuObserver.currentScreen == SCREEN_NAMES.HELP)?
        Help()
        : (menuObserver.currentScreen == SCREEN_NAMES.GENERAL_SETTING)?
          GeneralSetting()
        : (menuObserver.currentScreen == SCREEN_NAMES.SYNC_TO_CLOUD)?
          SyncToCloud()
        : Text("Oopps")
      );
  }
}
