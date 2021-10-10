import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Observables/OnboardObservable.dart';
import 'package:provider/provider.dart';


class CloudSetupScreen extends StatefulWidget {
  @override
  _CloudSetupScreenState createState() => _CloudSetupScreenState();
}

class _CloudSetupScreenState extends State<CloudSetupScreen> {
  @override
  Widget build(BuildContext context) {
    final onboardingObserver = Provider.of<OnboardObserver>(context);

    return Observer(builder: (_) =>
        Scaffold(
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
        )
      ],
    ))));
  }
}
