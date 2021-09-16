import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'HomeScreen.dart';
import 'Setting.dart';
import 'Bottom_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 35,
            )),
        toolbarHeight: 90,
        title: Text('Home',
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
      body: Column(

      children: <Widget>[
      Align(
      alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(left: 10.0,),

          child: Text(
            "Would you like to Speak \n or write a note?",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,)

          ),
        ),
      ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 70),
                height: 301,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Column(children: [
                    Padding(
                      padding: new EdgeInsets.all(40.0),
                    ),
                    Image(
                      image: AssetImage("assets/images/mic.png"),
                      color: Colors.white,
                      height: 129.89,
                      width: 100.82,
                    ),
                    Text('Speak',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black))
                  ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, right: 20.0, top: 70),
                height: 301,
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
                    Navigator.pushNamed(context, '/save-note');
                  },
                    child: Column(children: [
                    Padding(
                      padding: new EdgeInsets.all(20.0),
                    ),
                    Image(
                      image: AssetImage("assets/images/Note.png"),
                      color: Colors.white,
                      height: 170,
                      width: 155,
                    ),
                    Text('Text',

                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            ))
                  ]),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
