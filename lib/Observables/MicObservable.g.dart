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

  final _$micIsExpectedToListenAtom =
      Atom(name: '_AbstractMicObserver.micIsExpectedToListen');

  @override
  bool get micIsExpectedToListen {
    _$micIsExpectedToListenAtom.reportRead();
    return super.micIsExpectedToListen;
  }

  @override
  set micIsExpectedToListen(bool value) {
    _$micIsExpectedToListenAtom.reportWrite(value, super.micIsExpectedToListen,
        () {
      super.micIsExpectedToListen = value;
    });
  }

  final _$micStatusAtom = Atom(name: '_AbstractMicObserver.micStatus');

  @override
  String get micStatus {
    _$micStatusAtom.reportRead();
    return super.micStatus;
  }

  @override
  set micStatus(String value) {
    _$micStatusAtom.reportWrite(value, super.micStatus, () {
      super.micStatus = value;
    });
  }

  final _$speechConfidenceAtom =
      Atom(name: '_AbstractMicObserver.speechConfidence');

  @override
  double get speechConfidence {
    _$speechConfidenceAtom.reportRead();
    return super.speechConfidence;
  }

  @override
  set speechConfidence(double value) {
    _$speechConfidenceAtom.reportWrite(value, super.speechConfidence, () {
      super.speechConfidence = value;
    });
  }

  final _$systemUserMessageAtom =
      Atom(name: '_AbstractMicObserver.systemUserMessage');

  @override
  ObservableList<dynamic> get systemUserMessage {
    _$systemUserMessageAtom.reportRead();
    return super.systemUserMessage;
  }

  @override
  set systemUserMessage(ObservableList<dynamic> value) {
    _$systemUserMessageAtom.reportWrite(value, super.systemUserMessage, () {
      super.systemUserMessage = value;
    });
  }

  final _$mainNavObserverAtom =
      Atom(name: '_AbstractMicObserver.mainNavObserver');

  @override
  dynamic get mainNavObserver {
    _$mainNavObserverAtom.reportRead();
    return super.mainNavObserver;
  }

  @override
  set mainNavObserver(dynamic value) {
    _$mainNavObserverAtom.reportWrite(value, super.mainNavObserver, () {
      super.mainNavObserver = value;
    });
  }

  final _$noteObserverAtom = Atom(name: '_AbstractMicObserver.noteObserver');

  @override
  dynamic get noteObserver {
    _$noteObserverAtom.reportRead();
    return super.noteObserver;
  }

  @override
  set noteObserver(dynamic value) {
    _$noteObserverAtom.reportWrite(value, super.noteObserver, () {
      super.noteObserver = value;
    });
  }

  final _$setMessageInputTextAsyncAction =
      AsyncAction('_AbstractMicObserver.setMessageInputText');

  @override
  Future<void> setMessageInputText(dynamic value) {
    return _$setMessageInputTextAsyncAction
        .run(() => super.setMessageInputText(value));
  }

  final _$_AbstractMicObserverActionController =
      ActionController(name: '_AbstractMicObserver');

  @override
  void toggleListeningMode() {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.toggleListeningMode');
    try {
      return super.toggleListeningMode();
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _clearChatHistory() {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver._clearChatHistory');
    try {
      return super._clearChatHistory();
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addUserMessage(String userMsg) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.addUserMessage');
    try {
      return super.addUserMessage(userMsg);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSystemMessage(NLUResponse nluResponse) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.addSystemMessage');
    try {
      return super.addSystemMessage(nluResponse);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNoteObserver(dynamic observer) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.setNoteObserver');
    try {
      return super.setNoteObserver(observer);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMainNavObserver(dynamic observer) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.setMainNavObserver');
    try {
      return super.setMainNavObserver(observer);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMsgTextInput() {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.clearMsgTextInput');
    try {
      return super.clearMsgTextInput();
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVoiceMsgTextInput(dynamic value) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.setVoiceMsgTextInput');
    try {
      return super.setVoiceMsgTextInput(value);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fufillNLUTask(NLUResponse nluResponse) {
    final _$actionInfo = _$_AbstractMicObserverActionController.startAction(
        name: '_AbstractMicObserver.fufillNLUTask');
    try {
      return super.fufillNLUTask(nluResponse);
    } finally {
      _$_AbstractMicObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messageInputText: ${messageInputText},
micIsExpectedToListen: ${micIsExpectedToListen},
micStatus: ${micStatus},
speechConfidence: ${speechConfidence},
systemUserMessage: ${systemUserMessage},
mainNavObserver: ${mainNavObserver},
noteObserver: ${noteObserver}
    ''';
  }
}
