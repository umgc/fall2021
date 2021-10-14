import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Services/LocaleService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';

List<FontSize> fontSizes = [FontSize.SMALL, FontSize.MEDIUM, FontSize.LARGE];

List<AppTheme> themes = [AppTheme.BLUE, AppTheme.PINK];

List<String> daysToKeepFilesOptions = ["1", "3", "5", "7", "14", "Forever"];

class Settings extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  var noteFontSize;
  var menuFontSize;
  var daysToKeepFiles;
  var language;
  var appTheme;

  @override
  void initState() {
    SettingObserver initialSetting = SettingObserver();
    noteFontSize = initialSetting.userSettings.noteFontSize;
    menuFontSize = initialSetting.userSettings.menuFontSize;
    daysToKeepFiles = initialSetting.userSettings.daysToKeepFiles;
    language = initialSetting.userSettings.locale;
    appTheme = initialSetting.userSettings.appTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingObserver = Provider.of<SettingObserver>(context);

    fontSizeToDisplayName(FontSize fontSize) {
      switch (fontSize) {
        case FontSize.SMALL:
          {
            return I18n.of(context)!.small;
          }
        case FontSize.MEDIUM:
          {
            return I18n.of(context)!.medium;
          }
        case FontSize.LARGE:
          {
            return I18n.of(context)!.large;
          }
        default:
          throw new UnimplementedError('not implemented');
      }
    }

    themeToDisplayName(AppTheme appTheme) {
      switch (appTheme) {
        case AppTheme.BLUE:
          {
            return I18n.of(context)!.blue;
          }
        case AppTheme.PINK:
          {
            return I18n.of(context)!.pink;
          }
        default:
          throw new UnimplementedError('not implemented');
      }
    }

    return Observer(
      builder: (context) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            Text(I18n.of(context)!.daysToKeepNotes,
                style: Theme.of(context).textTheme.bodyText2),
            Padding(
              padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.promptNoteDeletionTimeline,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  icon: Icon(
                    // Add this
                    Icons.edit_sharp, // Add this
                    color: Colors.blue, // Add this
                  ),
                  value: settingObserver.userSettings.daysToKeepFiles,
                  onChanged: (newValue) {
                    setState(() {
                      daysToKeepFiles = newValue;
                    });
                    settingObserver.userSettings.daysToKeepFiles =
                        daysToKeepFiles;
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: daysToKeepFilesOptions.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem, child: Text((valueItem)));
                  }).toList(),
                ),
              ),
            ),
            Text(I18n.of(context)!.noteFontSize,
                style: Theme.of(context).textTheme.bodyText2),
            Padding(
              padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.promptNoteFontSize,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  icon: Icon(
                    // Add this
                    Icons.edit_sharp, // Add this
                    color: Colors.blue, // Add this
                  ),
                  value: settingObserver.userSettings.noteFontSize,
                  onChanged: (newValue) {
                    setState(() {
                      noteFontSize = newValue ?? DEFAULT_FONT_SIZE;
                    });
                    settingObserver.userSettings.noteFontSize = noteFontSize;
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: fontSizes.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem,
                        child: Text((fontSizeToDisplayName(valueItem))));
                  }).toList(),
                ),
              ),
            ),
            Text(I18n.of(context)!.menuFontSize,
                style: Theme.of(context).textTheme.bodyText2),
            Padding(
              padding: EdgeInsets.fromLTRB(1.0, 2.0, 3.0, 4.0),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.promptMenuFontSize,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  icon: Icon(
                    // Add this
                    Icons.edit_sharp, // Add this
                    color: Colors.blue, // Add this
                  ),
                  value: settingObserver.userSettings.menuFontSize,
                  onChanged: (newValue) {
                    setState(() {
                      menuFontSize = newValue ?? DEFAULT_FONT_SIZE;
                    });
                    settingObserver.userSettings.menuFontSize = menuFontSize;
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: fontSizes.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem,
                        child: Text((fontSizeToDisplayName(valueItem))));
                  }).toList(),
                ),
              ),
            ),
            Text(I18n.of(context)!.language,
                style: Theme.of(context).textTheme.bodyText2),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.selectLanguage,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  //icon: Icon(                // Add this
                  //  Icons.arrow_drop_down_outlined,  // Add this
                  //  color: Colors.blue,   // Add this
                  //),
                  icon: Image.asset(
                    // Add this
                    //Icons.arrow_drop_down_outlined, //size: 38.0,  // Add this
                    "assets/images/dropdownarrow.png",
                    width: 28,
                    height: 18,
                    //Icons.arrow_drop_down_outlined,
                    //size: 31,
                    color: Colors.blue, // Add this
                  ),
                  value: language,
                  onChanged: (newLocale) {
                    setState(() {
                      if (newLocale != null) {
                        language = newLocale;
                      }
                    });
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: GeneratedLocalizationsDelegate()
                      .supportedLocales
                      .map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem,
                        child: Text((LocaleService.getDisplayLanguage(
                            valueItem.languageCode)["name"])));
                  }).toList(),
                ),
              ),
            ),
            Text(I18n.of(context)!.theme,
                style: Theme.of(context).textTheme.bodyText2),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: 60,
                height: 40,
                padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButton(
                  hint: Text(
                    I18n.of(context)!.promptTheme,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  //icon: Icon(                // Add this
                  //  Icons.arrow_drop_down_outlined,  // Add this
                  //  color: Colors.blue,   // Add this
                  //),
                  icon: Image.asset(
                    // Add this
                    //Icons.arrow_drop_down_outlined, //size: 38.0,  // Add this
                    "assets/images/dropdownarrow.png",
                    width: 28,
                    height: 18,
                    //Icons.arrow_drop_down_outlined,
                    //size: 31,
                    color: Colors.blue, // Add this
                  ),
                  value: appTheme,
                  onChanged: (newTheme) {
                    setState(() {
                      appTheme = newTheme;
                    });
                    settingObserver.userSettings.appTheme = appTheme;
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyText1,
                  items: themes.map((theme) {
                    return DropdownMenuItem(
                        value: theme, child: Text(themeToDisplayName(theme)));
                  }).toList(),
                ),
              ),
            ),
            //SAVE BUTTON
            Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 4, right: 0, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  settingObserver.saveSetting();
                  I18n.onLocaleChanged!(language!);
                },
                child: Text(
                  I18n.of(context)!.save,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),

            //RESET BUTTON//
            Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  Setting setting = settingObserver.userSettings;
                  setting.menuFontSize = DEFAULT_FONT_SIZE;
                  setting.noteFontSize = DEFAULT_FONT_SIZE;
                  setting.daysToKeepFiles = DEFAULT_DAYS_TO_KEEP_FILES;
                  setting.locale = DEFAULT_LOCALE;
                  setting.appTheme = DEFAULT_APP_THEME;
                  settingObserver.saveSetting();
                  noteFontSize = setting.noteFontSize;
                  menuFontSize = setting.menuFontSize;
                  daysToKeepFiles = setting.daysToKeepFiles;
                  language = setting.locale;
                  appTheme = setting.appTheme;
                  I18n.onLocaleChanged!(DEFAULT_LOCALE);
                },
                child: Text(
                  I18n.of(context)!.resetSettings,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),

            //SECURITY BUTTON
            Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  I18n.of(context)!.securitySettings,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),

            //CANCEL BUTTON
            Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 2, right: 0, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  final screenNav =
                      Provider.of<MenuObserver>(context, listen: false);
                  screenNav.changeScreen(MENU_SCREENS.MENU);
                },
                child: Text(
                  I18n.of(context)!.cancel,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(30, 40), primary: Colors.grey),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
