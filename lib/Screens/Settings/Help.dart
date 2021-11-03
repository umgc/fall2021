import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Help.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/HelpObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Settings/VideoPlayer.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/Utility/Video_Player.dart';
import 'package:video_player/video_player.dart';

class Help extends StatefulWidget {
  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    final helpObserver = Provider.of<HelpObserver>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:HelpTable(helpObserver.helpItems, () => {"Displayed Help Content"})
        
        );
  }
}

/// View Notes page
class HelpTable extends StatelessWidget {
  final List<HelpContent> helpItems;
  final Function? onListItemClickCallBackFn;
  //Flutter will autto assign this param to usersNotes
  HelpTable(this.helpItems, this.onListItemClickCallBackFn);
  static const ICON_SIZE = 40.00;
  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);

    final settingObserver = Provider.of<SettingObserver>(context);

    const TEXT_STYLE = TextStyle(fontSize: 20);
    const HEADER_TEXT_STYLE = const TextStyle(fontSize: 20);

    var rowHeight = (MediaQuery.of(context).size.height - 56) / 5;
    var noteWidth = MediaQuery.of(context).size.width * 0.35;

    //noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    return ListView.builder(
       shrinkWrap: true,
      itemCount: helpItems.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            onTap: () => {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => (VideoPlayerScreen())),
                    )
            },
            title: Text(
                '${helpItems[index].title}',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center),
            trailing: 
            Icon( 
              Icons.play_arrow,
              size: ICON_SIZE,
            )
          ),
        );
      },
    );
  }
}
