// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoteObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteObserver on _AbstractNoteObserver, Store {
  final _$currentScreenAtom = Atom(name: '_AbstractNoteObserver.currentScreen');

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

  final _$currNoteForDetailsAtom =
      Atom(name: '_AbstractNoteObserver.currNoteForDetails');

  @override
  TextNote? get currNoteForDetails {
    _$currNoteForDetailsAtom.reportRead();
    return super.currNoteForDetails;
  }

  @override
  set currNoteForDetails(TextNote? value) {
    _$currNoteForDetailsAtom.reportWrite(value, super.currNoteForDetails, () {
      super.currNoteForDetails = value;
    });
  }

  final _$usersNotesAtom = Atom(name: '_AbstractNoteObserver.usersNotes');

  @override
  List<TextNote> get usersNotes {
    _$usersNotesAtom.reportRead();
    return super.usersNotes;
  }

  @override
  set usersNotes(List<TextNote> value) {
    _$usersNotesAtom.reportWrite(value, super.usersNotes, () {
      super.usersNotes = value;
    });
  }

  final _$_AbstractNoteObserverActionController =
      ActionController(name: '_AbstractNoteObserver');

  @override
  void addNote(TextNote note) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.addNote');
    try {
      return super.addNote(note);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteNote(TextNote? note) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.deleteNote');
    try {
      return super.deleteNote(note);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrNoteIdForDetails(dynamic noteId) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.setCurrNoteIdForDetails');
    try {
      return super.setCurrNoteIdForDetails(noteId);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotes(dynamic notes) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.setNotes');
    try {
      return super.setNotes(notes);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeScreen(String name) {
    final _$actionInfo = _$_AbstractNoteObserverActionController.startAction(
        name: '_AbstractNoteObserver.changeScreen');
    try {
      return super.changeScreen(name);
    } finally {
      _$_AbstractNoteObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
currNoteForDetails: ${currNoteForDetails},
usersNotes: ${usersNotes}
    ''';
  }
}
