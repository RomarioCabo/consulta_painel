// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StateController on StateControllerBase, Store {
  final _$requestStateInitialAtom =
      Atom(name: 'StateControllerBase.requestStateInitial');

  @override
  RequestState get requestStateInitial {
    _$requestStateInitialAtom.reportRead();
    return super.requestStateInitial;
  }

  @override
  set requestStateInitial(RequestState value) {
    _$requestStateInitialAtom.reportWrite(value, super.requestStateInitial, () {
      super.requestStateInitial = value;
    });
  }

  final _$requestStateCrudAtom =
      Atom(name: 'StateControllerBase.requestStateCrud');

  @override
  RequestState get requestStateCrud {
    _$requestStateCrudAtom.reportRead();
    return super.requestStateCrud;
  }

  @override
  set requestStateCrud(RequestState value) {
    _$requestStateCrudAtom.reportWrite(value, super.requestStateCrud, () {
      super.requestStateCrud = value;
    });
  }

  final _$errorNameAtom = Atom(name: 'StateControllerBase.errorName');

  @override
  String get errorName {
    _$errorNameAtom.reportRead();
    return super.errorName;
  }

  @override
  set errorName(String value) {
    _$errorNameAtom.reportWrite(value, super.errorName, () {
      super.errorName = value;
    });
  }

  final _$errorAcronymAtom = Atom(name: 'StateControllerBase.errorAcronym');

  @override
  String get errorAcronym {
    _$errorAcronymAtom.reportRead();
    return super.errorAcronym;
  }

  @override
  set errorAcronym(String value) {
    _$errorAcronymAtom.reportWrite(value, super.errorAcronym, () {
      super.errorAcronym = value;
    });
  }

  final _$validatedAllAtom = Atom(name: 'StateControllerBase.validatedAll');

  @override
  bool get validatedAll {
    _$validatedAllAtom.reportRead();
    return super.validatedAll;
  }

  @override
  set validatedAll(bool value) {
    _$validatedAllAtom.reportWrite(value, super.validatedAll, () {
      super.validatedAll = value;
    });
  }

  final _$messageAtom = Atom(name: 'StateControllerBase.message');

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$statesAtom = Atom(name: 'StateControllerBase.states');

  @override
  ObservableList<StateDto> get states {
    _$statesAtom.reportRead();
    return super.states;
  }

  @override
  set states(ObservableList<StateDto> value) {
    _$statesAtom.reportWrite(value, super.states, () {
      super.states = value;
    });
  }

  final _$getAllStatesAsyncAction =
      AsyncAction('StateControllerBase.getAllStates');

  @override
  Future<void> getAllStates() {
    return _$getAllStatesAsyncAction.run(() => super.getAllStates());
  }

  final _$getImageAsyncAction = AsyncAction('StateControllerBase.getImage');

  @override
  Future<void> getImage() {
    return _$getImageAsyncAction.run(() => super.getImage());
  }

  final _$StateControllerBaseActionController =
      ActionController(name: 'StateControllerBase');

  @override
  void validateName(String value) {
    final _$actionInfo = _$StateControllerBaseActionController.startAction(
        name: 'StateControllerBase.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAcronym(String value) {
    final _$actionInfo = _$StateControllerBaseActionController.startAction(
        name: 'StateControllerBase.validateAcronym');
    try {
      return super.validateAcronym(value);
    } finally {
      _$StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
requestStateInitial: ${requestStateInitial},
requestStateCrud: ${requestStateCrud},
errorName: ${errorName},
errorAcronym: ${errorAcronym},
validatedAll: ${validatedAll},
message: ${message},
states: ${states}
    ''';
  }
}
