import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {

  int id =1;
  late Permission permission;
  PermissionStatus permissionStatus = PermissionStatus.denied;

  void _listenForPermission() async {
    final status = await Permission.microphone.status;
    setState(() {
      permissionStatus = status;
    });
    switch (status) {
      case PermissionStatus.denied:
        permissionStatus.isDenied;
        break;
      case PermissionStatus.granted:
        permissionStatus.isGranted;
        break;
    }
  }

  Future<void> requestForPermission() async {
    final status = await Permission.microphone.request();
    setState(() {
      permissionStatus = status;

    });
  }

  @override
  void initState() {
    _listenForPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [
            Radio(
              value: 1,
              onChanged: (val) {
                setState(() {
                  permissionStatus.isGranted;
                      id =1;

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
                  Permission.microphone.status.isDenied;
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
    ));
  }
}
