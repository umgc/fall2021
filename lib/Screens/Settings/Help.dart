import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView(
            padding: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
            children: [

              //1ST BUTTON
              Container(
                width: 210,
                //color: Colors.grey,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),

                  onPressed: (){ print('Button Clicked.'); },

                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                  //color: Colors.pink,
                                  padding: EdgeInsets.fromLTRB(10, 16, 4, 16),
                                  child: Column(
                                    children: <Widget>[

                                      Align(
                                        alignment: Alignment.topLeft,

                                        child: Text(
                                          'How do I setup trigger?',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 24.4, color: Colors.black, fontWeight: FontWeight.w600),

                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 20,),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '5 minutes',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 22.4, color: Colors.black, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],

                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(21, 0, 10, 0),
                                  //alignment: Alignment.topRight,

                                  child: Icon(
                                    Icons.play_circle,
                                    color:Colors.white,
                                    size: 56,

                                  ),
                                ),

                              ],
                            ),


                          ],
                        ),
                      ],
                    ),

                  ),
                ),
              ),

              //2ND BUTTON
              Container(
                width: 210,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                //color: Colors.grey,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),

                  onPressed: (){ print('Button Clicked.'); },

                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                  //color: Colors.pink,
                                  padding: EdgeInsets.fromLTRB(10, 16, 4, 16),
                                  child: Column(
                                    children: <Widget>[
                                      //Row(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //children: <Widget>[Text('5 minutes',
                                      //style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.normal),)],),

                                      Align(
                                        alignment: Alignment.topLeft,

                                        child: Text(
                                          'How do I view my notes?',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 24.4, color: Colors.black, fontWeight: FontWeight.w600),

                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 20,),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '5 minutes',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 22.4, color: Colors.black, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],

                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                  child: Icon(
                                    Icons.play_circle,
                                    color:Colors.white,
                                    size: 56,
                                  ),
                                ),

                              ],
                            ),


                          ],
                        ),
                      ],
                    ),

                  ),
                ),
              ),




              //3RD BUTTON
              Container(
                width: 210,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                //color: Colors.grey,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),

                  onPressed: (){ print('Button Clicked.'); },

                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                  //color: Colors.pink,
                                  padding: EdgeInsets.fromLTRB(10, 16, 4, 16),
                                  child: Column(
                                    children: <Widget>[
                                      //Row(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //children: <Widget>[Text('5 minutes',
                                      //style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.normal),)],),

                                      Align(
                                        alignment: Alignment.topLeft,

                                        child: Text(
                                          'How do I edit a note?',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 24.4, color: Colors.black, fontWeight: FontWeight.w600),

                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 20,),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '5 minutes',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 22.4, color: Colors.black, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],

                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(45, 0, 10, 0),
                                  child: Icon(
                                    Icons.play_circle,
                                    color:Colors.white,
                                    size: 56,
                                  ),
                                ),

                              ],
                            ),


                          ],
                        ),
                      ],
                    ),

                  ),
                ),
              ),

              //4TH BUTTON
              Container(
                width: 210,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                //color: Colors.grey,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),

                  onPressed: (){ print('Button Clicked.'); },

                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                  //color: Colors.pink,
                                  padding: EdgeInsets.fromLTRB(10, 16, 4, 16),
                                  child: Column(
                                    children: <Widget>[
                                      //Row(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //children: <Widget>[Text('5 minutes',
                                      //style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.normal),)],),

                                      Align(
                                        alignment: Alignment.topLeft,

                                        child: Text(
                                          'How do I edit a ....?',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 24.4, color: Colors.black, fontWeight: FontWeight.w600),

                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 20,),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '5 minutes',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 22.4, color: Colors.black, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],

                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(67, 0, 10, 0),
                                  child: Icon(
                                    Icons.play_circle,
                                    color:Colors.white,
                                    size: 56,
                                  ),
                                ),

                              ],
                            ),


                          ],
                        ),
                      ],
                    ),

                  ),
                ),
              ),

            ],
          ),
        )
    );
  }

  Widget buildText(String text) => Container(
    margin: EdgeInsets.fromLTRB(0, 24, 0, 8),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    ),
  );

}
