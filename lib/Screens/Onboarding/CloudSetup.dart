import 'package:flutter/material.dart';

class CloudSetupScreen extends StatefulWidget {
  @override
  _CloudSetupScreenState createState() => _CloudSetupScreenState();
}

class _CloudSetupScreenState extends State<CloudSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("Onboarding Cloud Setup"),
        )
    );
  }
}
