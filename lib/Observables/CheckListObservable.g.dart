// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckListObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CheckListObserver on _AbstractCheckListObserver, Store {
  final _$noteObserverAtom =
      Atom(name: '_AbstractCheckListObserver.noteObserver');

  @override
  NoteObserver get noteObserver {
    _$noteObserverAtom.reportRead();
    return super.noteObserver;
  }

  @override
  set noteObserver(NoteObserver value) {
    _$noteObserverAtom.reportWrite(value, super.noteObserver, () {
      super.noteObserver = value;
    });
  }

  final _$dailyCheckListAtom =
      Atom(name: '_AbstractCheckListObserver.dailyCheckList');

  @override
  LinkedHashMap<TextNote, bool> get dailyCheckList {
    _$dailyCheckListAtom.reportRead();
    return super.dailyCheckList;
  }

  @override
  set dailyCheckList(LinkedHashMap<TextNote, bool> value) {
    _$dailyCheckListAtom.reportWrite(value, super.dailyCheckList, () {
      super.dailyCheckList = value;
    });
  }

  final _$_AbstractCheckListObserverActionController =
      ActionController(name: '_AbstractCheckListObserver');

  @override
  void setNotObserver(NoteObserver observer) {
    final _$actionInfo = _$_AbstractCheckListObserverActionController
        .startAction(name: '_AbstractCheckListObserver.setNotObserver');
    try {
      return super.setNotObserver(observer);
    } finally {
      _$_AbstractCheckListObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getDailyCheckList(String date) {
    final _$actionInfo = _$_AbstractCheckListObserverActionController
        .startAction(name: '_AbstractCheckListObserver.getDailyCheckList');
    try {
      return super.getDailyCheckList(date);
    } finally {
      _$_AbstractCheckListObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToCheckedItems(TextNote note) {
    final _$actionInfo = _$_AbstractCheckListObserverActionController
        .startAction(name: '_AbstractCheckListObserver.addToCheckedItems');
    try {
      return super.addToCheckedItems(note);
    } finally {
      _$_AbstractCheckListObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
noteObserver: ${noteObserver},
dailyCheckList: ${dailyCheckList}
    ''';
  }
}
