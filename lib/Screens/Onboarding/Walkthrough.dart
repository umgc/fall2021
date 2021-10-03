import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WalkthroughScreen extends StatefulWidget {
  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 20, 20),
          child: Text(
            "Here is a link to a brief"
            "walk-through of how to use"
            "the Memory Magic App.",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        new InkWell(
            child: new Text('Memory Magic Walk-Through',
                style: TextStyle(fontSize: 25, color: Colors.blueAccent)),
            onTap: () {
              const url = 'https://google.com';
              // TODO now it's google but we can change it to our url.
              launchURL(url);
            }),
      ],
    ));
  }
}
