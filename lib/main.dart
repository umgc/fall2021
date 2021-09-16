import 'package:flutter/material.dart';
import 'package:untitled3/Screens/Home.dart';
import 'package:untitled3/Screens/Setting.dart';
import 'package:untitled3/Services/saveNote.dart';
import 'package:untitled3/Screens/Note.dart';
import 'package:untitled3/Services/notedetails.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),

      routes: {
        '/save-note': (context) => SaveNote(),

        '/view-notes': (context) => ViewNotes(),
        '/note-details' :(context) => NoteDetails(),
        '/Setting' :(context) => Setting(),
      },

    );
  }
}
