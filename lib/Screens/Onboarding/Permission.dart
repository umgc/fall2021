import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/MicObservable.dart';
import '../../Observables/OnboardObservable.dart';

class PermissionScreen extends StatefulWidget {
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool denied = false;
  int id = 1;

  @override
  Widget build(BuildContext context) {
    final onboardingObserver = Provider.of<OnboardObserver>(context);
    return Observer(builder: (_) =>
        Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 20, 20),
          child: Text(
            "Do we have permission to access your microphone?",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 1,
              onChanged: (val) {
                setState(() {
                  onboardingObserver.micAccessAllowed = true;
                  denied = false;
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
                onboardingObserver.micAccessAllowed = false;
                id = 2;
                denied = true;
                });
                },
              groupValue: id,
            ),
            Text(
              'No',
              style: new TextStyle(fontSize: 17.0),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Container(
            child: Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 3),
              ),
              child: Text(
                "NOTE: This permission will allow all types of voice interaction.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        if (denied)
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 300, 15, 0),
            child: Container(
              child: Text(
                "You will have a limited features "
                "without allowing permission to "
                "access the microphone.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
      ],
    )));
  }
}
