import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Observables/OnboardObservable.dart';

class LimitedAccessScreen extends StatefulWidget {
  @override
  _LimitedAccessScreenState createState() => _LimitedAccessScreenState();
}

class _LimitedAccessScreenState extends State<LimitedAccessScreen> {
  @override
  Widget build(BuildContext context) {
    final OboardObserver = Provider.of<OnboardObserver>(context);
    return Scaffold(
      body: Container(
        child: Column(children: [
          Text("You will have access to limited "
              "features without allowing"
              "permission to access your microphone"
              "Would you like to continue?"),
        ]),
      ),
      persistentFooterButtons: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ElevatedButton(
            child: Text("BACK"),
            onPressed: () => {OboardObserver.moveToPrevScreen()},
          ),
          ElevatedButton(
            child: Text("NEXT"),
            onPressed: () => {OboardObserver.moveToNextScreen()},
          ),
        ])
      ],
    );
  }
}
