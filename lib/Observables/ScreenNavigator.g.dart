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
  dynamic get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(dynamic value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$screenTitleAtom = Atom(name: '_AbstractMainNavObserver.screenTitle');

  @override
  String get screenTitle {
    _$screenTitleAtom.reportRead();
    return super.screenTitle;
  }

  @override
  set screenTitle(String value) {
    _$screenTitleAtom.reportWrite(value, super.screenTitle, () {
      super.screenTitle = value;
    });
  }

  final _$bottomNavIndexAtom =
      Atom(name: '_AbstractMainNavObserver.bottomNavIndex');

  @override
  int get bottomNavIndex {
    _$bottomNavIndexAtom.reportRead();
    return super.bottomNavIndex;
  }

  @override
  set bottomNavIndex(int value) {
    _$bottomNavIndexAtom.reportWrite(value, super.bottomNavIndex, () {
      super.bottomNavIndex = value;
    });
  }

  final _$_AbstractMainNavObserverActionController =
      ActionController(name: '_AbstractMainNavObserver');

  @override
  void changeScreen(dynamic screen) {
    final _$actionInfo = _$_AbstractMainNavObserverActionController.startAction(
        name: '_AbstractMainNavObserver.changeScreen');
    try {
      return super.changeScreen(screen);
    } finally {
      _$_AbstractMainNavObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String title) {
    final _$actionInfo = _$_AbstractMainNavObserverActionController.startAction(
        name: '_AbstractMainNavObserver.setTitle');
    try {
      return super.setTitle(title);
    } finally {
      _$_AbstractMainNavObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBottomNavIndex(int index) {
    final _$actionInfo = _$_AbstractMainNavObserverActionController.startAction(
        name: '_AbstractMainNavObserver.setBottomNavIndex');
    try {
      return super.setBottomNavIndex(index);
    } finally {
      _$_AbstractMainNavObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
screenTitle: ${screenTitle},
bottomNavIndex: ${bottomNavIndex}
    ''';
  }
}
