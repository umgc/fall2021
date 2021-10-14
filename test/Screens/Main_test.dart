// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:untitled3/Screens/Main.dart';
// import 'package:untitled3/generated/i18n.dart';


// void main() {
//   final i18n = I18n.delegate;
//   testWidgets('MainNavigator finds all bottom navigation information - default', (WidgetTester tester) async {
//     Widget createWidgetForTesting({required Widget child}){
//       return MaterialApp(
//         home: child,
//         localizationsDelegates: [
//           i18n,
//         ],
//       );
//     }

//     await tester.pumpWidget(createWidgetForTesting(child: new MainNavigator()));
//     await tester.pumpAndSettle();
//     final notesScreenNameFinder = find.text('Notes');
//     final micScreenNameFinder = find.text('Mic');
//     final menuScreenNameFinder = find.text('Menu');
//     final notificationsScreenNameFinder = find.text('Notifications');
//     expect(menuScreenNameFinder, findsOneWidget);
//     expect(notificationsScreenNameFinder, findsOneWidget);
//     expect(notesScreenNameFinder, findsOneWidget);
//     expect(micScreenNameFinder, findsOneWidget);
//   });

//   testWidgets('MainNavigator finds all bottom navigation information - spanish', (WidgetTester tester) async {
//     I18n.locale = new Locale("es", "US");
//     Widget createWidgetForTesting({required Widget child}){
//       return MaterialApp(
//         home: child,
//         localizationsDelegates: [
//           i18n,
//         ],
//       );
//     }
//     await tester.pumpWidget(createWidgetForTesting(child: new MainNavigator()));
//     await tester.pumpAndSettle();
//     final notesScreenNameFinder = find.text('Notas');
//     final micScreenNameFinder = find.text('Micrófono');
//     final menuScreenNameFinder = find.text('Menú');
//     final notificationsScreenNameFinder = find.text('Notificaciones');
//     expect(menuScreenNameFinder, findsOneWidget);
//     expect(notificationsScreenNameFinder, findsOneWidget);
//     expect(notesScreenNameFinder, findsOneWidget);
//     expect(micScreenNameFinder, findsOneWidget);
//   });
// }

