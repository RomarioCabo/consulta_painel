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

  final _$requestStateSaveAtom =
      Atom(name: 'StateControllerBase.requestStateSave');

  @override
  RequestState get requestStateSave {
    _$requestStateSaveAtom.reportRead();
    return super.requestStateSave;
  }

  @override
  set requestStateSave(RequestState value) {
    _$requestStateSaveAtom.reportWrite(value, super.requestStateSave, () {
      super.requestStateSave = value;
    });
  }

  final _$requestStateUpdateAtom =
      Atom(name: 'StateControllerBase.requestStateUpdate');

  @override
  RequestState get requestStateUpdate {
    _$requestStateUpdateAtom.reportRead();
    return super.requestStateUpdate;
  }

  @override
  set requestStateUpdate(RequestState value) {
    _$requestStateUpdateAtom.reportWrite(value, super.requestStateUpdate, () {
      super.requestStateUpdate = value;
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

  final _$errorImageAtom = Atom(name: 'StateControllerBase.errorImage');

  @override
  String get errorImage {
    _$errorImageAtom.reportRead();
    return super.errorImage;
  }

  @override
  set errorImage(String value) {
    _$errorImageAtom.reportWrite(value, super.errorImage, () {
      super.errorImage = value;
    });
  }

  final _$validateAllAtom = Atom(name: 'StateControllerBase.validateAll');

  @override
  bool get validateAll {
    _$validateAllAtom.reportRead();
    return super.validateAll;
  }

  @override
  set validateAll(bool value) {
    _$validateAllAtom.reportWrite(value, super.validateAll, () {
      super.validateAll = value;
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

  final _$imageNameAtom = Atom(name: 'StateControllerBase.imageName');

  @override
  String get imageName {
    _$imageNameAtom.reportRead();
    return super.imageName;
  }

  @override
  set imageName(String value) {
    _$imageNameAtom.reportWrite(value, super.imageName, () {
      super.imageName = value;
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

  final _$saveAsyncAction = AsyncAction('StateControllerBase.save');

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
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
  void validateImage(String value) {
    final _$actionInfo = _$StateControllerBaseActionController.startAction(
        name: 'StateControllerBase.validateImage');
    try {
      return super.validateImage(value);
    } finally {
      _$StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatedAll(String name, String acronym, String image) {
    final _$actionInfo = _$StateControllerBaseActionController.startAction(
        name: 'StateControllerBase.validatedAll');
    try {
      return super.validatedAll(name, acronym, image);
    } finally {
      _$StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
requestStateInitial: ${requestStateInitial},
requestStateSave: ${requestStateSave},
requestStateUpdate: ${requestStateUpdate},
errorName: ${errorName},
errorAcronym: ${errorAcronym},
errorImage: ${errorImage},
validateAll: ${validateAll},
message: ${message},
imageName: ${imageName},
states: ${states}
    ''';
  }
}
