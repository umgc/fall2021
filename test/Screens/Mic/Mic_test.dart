import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' show ObservableList;
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/MicObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Mic/Mic.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:mockito/annotations.dart';
import 'Mic_test.mocks.dart';

Widget createWidgetForTesting(
    {required Widget child,
    required MockSettingObserver mockObs,
    required MenuObserver menuObs,
    required MicObserver micObs,
    required NoteObserver noteObs,
    required MainNavObserver mainNavObs}) {
  final i18n = I18n.delegate;
  when(mockObs.userSettings).thenReturn(new Setting());

  return MultiProvider(
      providers: [
        Provider<MicObserver>(create: (_) => micObs),
        Provider<SettingObserver>(create: (_) => mockObs),
        Provider<MenuObserver>(create: (_) => menuObs),
        Provider<NoteObserver>(create: (_) => noteObs),
        Provider<MainNavObserver>(create: (_) => mainNavObs)
      ],
      child: MaterialApp(
        home: child,
        localizationsDelegates: [
          i18n,
        ],
      ));
}

@GenerateMocks(
    [SettingObserver, MenuObserver, MicObserver, NoteObserver, MainNavObserver])
void main() {
  group('Mic - Widget', () {
    testWidgets('Settings Widget Finds All Default Text',
        (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();
      final micObs = MockMicObserver();
      when(micObs.messageInputText).thenReturn('input text');
      final obs = ObservableList();
      obs.insert(0, 'input text');
      when(micObs.systemUserMessage).thenAnswer((_) => obs);

      final noteObs = MockNoteObserver();
      final mainNavObs = MockMainNavObserver();
      await tester.pumpWidget(createWidgetForTesting(
          child: new SpeechScreen(),
          mockObs: mockObs,
          menuObs: menuObs,
          micObs: micObs,
          noteObs: noteObs,
          mainNavObs: mainNavObs));
      await tester.pumpAndSettle();
      final inputFinder = find.text('input text');
      expect(inputFinder, findsOneWidget);

    });
  });
}
