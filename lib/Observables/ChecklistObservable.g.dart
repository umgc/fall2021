// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChecklistObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChecklistObserver on _AbstractChecklistObserver, Store {
  final _$IsCheckedAtom = Atom(name: '_AbstractChecklistObserver.IsChecked');

  @override
  bool get IsChecked {
    _$IsCheckedAtom.reportRead();
    return super.IsChecked;
  }

  @override
  set IsChecked(bool value) {
    _$IsCheckedAtom.reportWrite(value, super.IsChecked, () {
      super.IsChecked = value;
    });
  }

  final _$_AbstractChecklistObserverActionController =
      ActionController(name: '_AbstractChecklistObserver');

  @override
  void checked() {
    final _$actionInfo = _$_AbstractChecklistObserverActionController
        .startAction(name: '_AbstractChecklistObserver.checked');
    try {
      return super.checked();
    } finally {
      _$_AbstractChecklistObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unChecked() {
    final _$actionInfo = _$_AbstractChecklistObserverActionController
        .startAction(name: '_AbstractChecklistObserver.unChecked');
    try {
      return super.unChecked();
    } finally {
      _$_AbstractChecklistObserverActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
IsChecked: ${IsChecked}
    ''';
  }
}
