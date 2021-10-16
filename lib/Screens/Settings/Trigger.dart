import 'package:flutter/material.dart';
import 'package:untitled3/Components/CancelButton.dart';

class Trigger extends StatefulWidget {
  @override
  TriggerState createState() => TriggerState();
}

class TriggerState extends State<Trigger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView(
            padding: EdgeInsets.only(left: 12, top: 0, right: 12, bottom: 0),
            children: [
              buildText('To start recording:'),
              Container(
                child: Text('Can you say that again?'),
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,

                  ),
                ),
              ),

              SizedBox(height: 0,),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(1),
                    border: OutlineInputBorder(

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero, topRight: Radius.zero, bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5),),
                    )
                ),
              ),

              buildText('To end recording:'),
              Container(
                child: Text('Got'),
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              SizedBox(height: 0,),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(1),
                    border: OutlineInputBorder(
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero, topRight: Radius.zero, bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5),),
                    )
                ),
              ),

              buildText('Playback notes:'),
              Container(
                child: Text('Talking about'),
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              SizedBox(height: 0,),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(1),
                    border: OutlineInputBorder(
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero, topRight: Radius.zero, bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5),),
                    )
                ),
              ),

              //SAVE BUTTON
              Container(
                padding: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                child: ElevatedButton(

                  onPressed: () {},
                  child: Text("Save", style: TextStyle(fontSize: 22),),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(30, 40),
                      primary: Colors.lightBlue,
                      onPrimary: Colors.black
                  ),
                ),
              ),

              //CANCEL BUTTON
              cancelButton(context)
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
