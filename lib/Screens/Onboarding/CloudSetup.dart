import 'package:flutter/material.dart';

class CloudSetupScreen extends StatefulWidget {
  @override
  _CloudSetupScreenState createState() => _CloudSetupScreenState();
}

class _CloudSetupScreenState extends State<CloudSetupScreen> {
  int id = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            body: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 20, 20),
          child: Text(
            "Would you like to setup a cloud account?",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: 1,
              onChanged: (val) {
                setState(() {
                  id = 1;
                });
              },
              groupValue: id,
            ),
            Text(
              'Yes',
              style: new TextStyle(fontSize: 17.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(70.0, 22.0, 0.0, 8.0),
            ),
            Radio(
              value: 2,
              onChanged: (val) {
                setState(() {
                  id = 2;
                });

                id = 2;
              },
              groupValue: id,
            ),
            Text(
              'No',
              style: new TextStyle(fontSize: 17.0),
            ),
          ],
        )
      ],
    )));
  }
}
