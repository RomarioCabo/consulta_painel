import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:painel_cunsulta/shared/models/form/authenticate_form.dart';
import 'package:painel_cunsulta/shared/repositories/api/auth_repository.dart';
import 'package:painel_cunsulta/shared/repositories/api/helpers/request_state.dart';
import 'package:painel_cunsulta/shared/repositories/local_storage_shared_preferences/local_storage_shared_preferences.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  BuildContext context;

  TextEditingController textEditingControllerEmail =
      TextEditingController(text: "romariocabo2012@gmail.com");
  TextEditingController textEditingControllerPassword =
      TextEditingController(text: "123");

  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  @observable
  RequestState requestState = Initial();

  @observable
  String errorUser;

  @observable
  String errorPassword;

  UserDto _user;

  AuthRepository _authRepository = AuthRepository();

  LocalStorageSharedPreferences _localStorageSharedPreferences =
      GetIt.I<LocalStorageSharedPreferences>();

  @action
  void validateUser(String value) {
    if (value.trim().isEmpty) {
      errorUser = error_required;
    } else {
      errorUser = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.trim().isEmpty) {
      errorPassword = error_required;
    } else {
      errorPassword = null;
    }
  }

  @action
  Future<void> login() async {
    validateUser(textEditingControllerEmail.text.trim());
    validatePassword(textEditingControllerPassword.text.trim());

    if (errorUser == null && errorPassword == null) {
      try {
        this.requestState = Loading();

        await Future.delayed(Duration(seconds: 1));

        _user = await _authRepository.login(
          authenticate: _getCredentials(
            email: textEditingControllerEmail.text.trim(),
            password: textEditingControllerPassword.text.trim(),
          ),
        );

        if (_user != null) {
          _localStorageSharedPreferences.saveUser(_user);
        }

        this.requestState = Completed();
      } catch (e) {
        this.requestState = Error(
          error: e.toString().replaceAll("Exception:", ""),
        );
      }
    }
  }

  AuthenticateForm _getCredentials({String email, String password}) {
    AuthenticateForm form = AuthenticateForm();
    form.email = email;
    form.password = password;

    return form;
  }
}
