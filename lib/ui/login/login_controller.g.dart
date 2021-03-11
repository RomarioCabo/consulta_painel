// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on LoginControllerBase, Store {
  final _$requestStateAtom = Atom(name: 'LoginControllerBase.requestState');

  @override
  RequestState get requestState {
    _$requestStateAtom.reportRead();
    return super.requestState;
  }

  @override
  set requestState(RequestState value) {
    _$requestStateAtom.reportWrite(value, super.requestState, () {
      super.requestState = value;
    });
  }

  final _$errorUserAtom = Atom(name: 'LoginControllerBase.errorUser');

  @override
  String get errorUser {
    _$errorUserAtom.reportRead();
    return super.errorUser;
  }

  @override
  set errorUser(String value) {
    _$errorUserAtom.reportWrite(value, super.errorUser, () {
      super.errorUser = value;
    });
  }

  final _$errorPasswordAtom = Atom(name: 'LoginControllerBase.errorPassword');

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

  final _$loginAsyncAction = AsyncAction('LoginControllerBase.login');

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$LoginControllerBaseActionController =
      ActionController(name: 'LoginControllerBase');

  @override
  void validateUser(String value) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction(
        name: 'LoginControllerBase.validateUser');
    try {
      return super.validateUser(value);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction(
        name: 'LoginControllerBase.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
requestState: ${requestState},
errorUser: ${errorUser},
errorPassword: ${errorPassword}
    ''';
  }
}
