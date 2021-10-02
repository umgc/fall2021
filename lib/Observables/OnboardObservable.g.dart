// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OnboardObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OnboardObserver on _AbstractOnboardObserver, Store {
  final _$currentScreenIndexAtom =
      Atom(name: '_AbstractOnboardObserver.currentScreenIndex');

  @override
  int get currentScreenIndex {
    _$currentScreenIndexAtom.reportRead();
    return super.currentScreenIndex;
  }

  @override
  set currentScreenIndex(int value) {
    _$currentScreenIndexAtom.reportWrite(value, super.currentScreenIndex, () {
      super.currentScreenIndex = value;
    });
  }

  final _$_AbstractOnboardObserverActionController =
      ActionController(name: '_AbstractOnboardObserver');

  @override
  void moveToNextScreen() {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.moveToNextScreen');
    try {
      return super.moveToNextScreen();
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void moveToPrevScreen() {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.moveToPrevScreen');
    try {
      return super.moveToPrevScreen();
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_AbstractOnboardObserverActionController.startAction(
        name: '_AbstractOnboardObserver.reset');
    try {
      return super.reset();
    } finally {
      _$_AbstractOnboardObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreenIndex: ${currentScreenIndex}
    ''';
  }
}
