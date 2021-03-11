// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserController on UserControllerBase, Store {
  final _$requestStateInitialAtom =
      Atom(name: 'UserControllerBase.requestStateInitial');

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
      Atom(name: 'UserControllerBase.requestStateCrud');

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

  final _$errorNameAtom = Atom(name: 'UserControllerBase.errorName');

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

  final _$errorEmailAtom = Atom(name: 'UserControllerBase.errorEmail');

  @override
  String get errorEmail {
    _$errorEmailAtom.reportRead();
    return super.errorEmail;
  }

  @override
  set errorEmail(String value) {
    _$errorEmailAtom.reportWrite(value, super.errorEmail, () {
      super.errorEmail = value;
    });
  }

  final _$errorPasswordAtom = Atom(name: 'UserControllerBase.errorPassword');

  @override
  String get errorPassword {
    _$errorPasswordAtom.reportRead();
    return super.errorPassword;
  }

  @override
  set errorPassword(String value) {
    _$errorPasswordAtom.reportWrite(value, super.errorPassword, () {
      super.errorPassword = value;
    });
  }

  final _$errorConfirmPasswordAtom =
      Atom(name: 'UserControllerBase.errorConfirmPassword');

  @override
  String get errorConfirmPassword {
    _$errorConfirmPasswordAtom.reportRead();
    return super.errorConfirmPassword;
  }

  @override
  set errorConfirmPassword(String value) {
    _$errorConfirmPasswordAtom.reportWrite(value, super.errorConfirmPassword,
        () {
      super.errorConfirmPassword = value;
    });
  }

  final _$validatedAllAtom = Atom(name: 'UserControllerBase.validatedAll');

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

  final _$messageAtom = Atom(name: 'UserControllerBase.message');

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

  final _$usersAtom = Atom(name: 'UserControllerBase.users');

  @override
  ObservableList<UserDto> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<UserDto> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$getAllUsersAsyncAction =
      AsyncAction('UserControllerBase.getAllUsers');

  @override
  Future<void> getAllUsers() {
    return _$getAllUsersAsyncAction.run(() => super.getAllUsers());
  }

  final _$saveAsyncAction = AsyncAction('UserControllerBase.save');

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  final _$deleteAsyncAction = AsyncAction('UserControllerBase.delete');

  @override
  Future<void> delete(UserDto selectedUser) {
    return _$deleteAsyncAction.run(() => super.delete(selectedUser));
  }

  final _$UserControllerBaseActionController =
      ActionController(name: 'UserControllerBase');

  @override
  void validateName(String value) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAll(
      String name, String email, String password, String confirmPassword) {
    final _$actionInfo = _$UserControllerBaseActionController.startAction(
        name: 'UserControllerBase.validateAll');
    try {
      return super.validateAll(name, email, password, confirmPassword);
    } finally {
      _$UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
requestStateInitial: ${requestStateInitial},
requestStateCrud: ${requestStateCrud},
errorName: ${errorName},
errorEmail: ${errorEmail},
errorPassword: ${errorPassword},
errorConfirmPassword: ${errorConfirmPassword},
validatedAll: ${validatedAll},
message: ${message},
users: ${users}
    ''';
  }
}
