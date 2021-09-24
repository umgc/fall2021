// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScreenNavigator.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainNavObserver on _AbstractMainNavObserver, Store {
  final _$currentScreenAtom =
      Atom(name: '_AbstractMainNavObserver.currentScreen');

  @override
  String get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(String value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$_AbstractMainNavObserverActionController =
      ActionController(name: '_AbstractMainNavObserver');

  @override
  void changeScreen(String name) {
    final _$actionInfo = _$_AbstractMainNavObserverActionController.startAction(
        name: '_AbstractMainNavObserver.changeScreen');
    try {
      return super.changeScreen(name);
    } finally {
      _$_AbstractMainNavObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen}
    ''';
  }
}