// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MicObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MicObserver on _AbstractMicObserver, Store {
  final _$messageInputTextAtom =
      Atom(name: '_AbstractMicObserver.messageInputText');

  @override
  String get messageInputText {
    _$messageInputTextAtom.reportRead();
    return super.messageInputText;
  }

  @override
  set messageInputText(String value) {
    _$messageInputTextAtom.reportWrite(value, super.messageInputText, () {
      super.messageInputText = value;
    });
  }

  final _$systemUserMessageAtom =
      Atom(name: '_AbstractMicObserver.systemUserMessage');

  @override
  List<dynamic> get systemUserMessage {
    _$systemUserMessageAtom.reportRead();
    return super.systemUserMessage;
  }

  @override
  set systemUserMessage(List<dynamic> value) {
    _$systemUserMessageAtom.reportWrite(value, super.systemUserMessage, () {
      super.systemUserMessage = value;
    });
  }

  final _$_AbstractMicObserverActionController =
      ActionController(name: '_AbstractMicObserver');

  @override
  void addUserMessage(String name) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.addUserMessage');
    try {
      return super.addUserMessage(name);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSystemMessage(NLUResponse name) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.addSystemMessage');
    try {
      return super.addSystemMessage(name);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fufillTask(NLUResponse name) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.fufillTask');
    try {
      return super.fufillTask(name);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messageInputText: ${messageInputText},
systemUserMessage: ${systemUserMessage}
    ''';
  }
}
