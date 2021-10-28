import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/MicObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/generated/i18n.dart';


Widget createWidgetForTesting({required Widget child}) {
  final i18n = I18n.delegate;

  return MultiProvider(
      providers: [
        Provider<MicObserver>(create: (_) => MicObserver()),
        Provider<MainNavObserver>(create: (_) => MainNavObserver()),
        Provider<SettingObserver>(create: (_) => SettingObserver()),
        Provider<NoteObserver>(create: (_) => NoteObserver()),
        Provider<MenuObserver>(create: (_) => MenuObserver())
      ],
      child: MaterialApp(
        home: child,
        localizationsDelegates: [
          i18n,
        ],
      ));
}


void main() {
  group('Widget', () {
    testWidgets(
        'MainNavigator finds all bottom navigation information - default',
        (WidgetTester tester) async {

      await tester
          .pumpWidget(createWidgetForTesting(child: new MainNavigator()));
      await tester.pumpAndSettle();
      final settingsScreenNameFinder = find.text('Settings');
      final triggerScreenNameFinder = find.text('Trigger');
      final helpScreenNameFinder = find.text('Help');
      expect(settingsScreenNameFinder, findsOneWidget);
      expect(triggerScreenNameFinder, findsOneWidget);
      expect(helpScreenNameFinder, findsOneWidget);

        });

    testWidgets(
        'MainNavigator finds all bottom navigation information - spanish',
        (WidgetTester tester) async {
      I18n.locale = new Locale("es", "US");


      await tester
          .pumpWidget(createWidgetForTesting(child: new MainNavigator()));
      await tester.pumpAndSettle();
      final settingsScreenNameFinder = find.text('Ajustes');
      final triggerScreenNameFinder = find.text('Desencadenar');
      final helpScreenNameFinder = find.text('Ayudar');
      expect(settingsScreenNameFinder, findsOneWidget);
      expect(triggerScreenNameFinder, findsOneWidget);
      expect(helpScreenNameFinder, findsOneWidget);
    });
  });
}
