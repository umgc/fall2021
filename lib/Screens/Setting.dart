import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: Row(
            children: [Text('Hello'), Text('Hello')],
          ),
        ), Center(
          child: Row(
            children: [Text('Hello'), Text('Hello')],
          ),
        )
      ],
    ));
  }
}
