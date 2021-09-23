// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoteObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteScreenNav on _AbstractNoteScreen, Store {
  final _$currentScreenAtom = Atom(name: '_AbstractNoteScreen.currentScreen');

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

  final _$usersNotesAtom = Atom(name: '_AbstractNoteScreen.usersNotes');

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

  final _$_AbstractNoteScreenActionController =
      ActionController(name: '_AbstractNoteScreen');

  @override
  void addNote(TextNote note) {
    final _$actionInfo = _$_AbstractNoteScreenActionController.startAction(
        name: '_AbstractNoteScreen.addNote');
    try {
      return super.addNote(note);
    } finally {
      _$_AbstractNoteScreenActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotes(dynamic notes) {
    final _$actionInfo = _$_AbstractNoteScreenActionController.startAction(
        name: '_AbstractNoteScreen.setNotes');
    try {
      return super.setNotes(notes);
    } finally {
      _$_AbstractNoteScreenActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeScreen(String name) {
    final _$actionInfo = _$_AbstractNoteScreenActionController.startAction(
        name: '_AbstractNoteScreen.changeScreen');
    try {
      return super.changeScreen(name);
    } finally {
      _$_AbstractNoteScreenActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
usersNotes: ${usersNotes}
    ''';
  }
}
