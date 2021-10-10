import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../Observables/OnboardObservable.dart';


class PermissionScreen extends StatefulWidget {
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {

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
            I18n.of,
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

              value:onboardingObserver.id,
              onChanged:(value) {
                onboardingObserver.permissionYes(1);
                },

              groupValue: 1 ,

            ),
            Text(
              'Yes',
              style: new TextStyle(fontSize: 17.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(70.0, 22.0, 0.0, 8.0),
            ),
            Radio(
              value:onboardingObserver.id ,
              onChanged: (val) => onboardingObserver.permissionNo(2),
             groupValue: 2,
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
        if (onboardingObserver.denied)
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
