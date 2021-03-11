import 'package:flutter/cupertino.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:painel_cunsulta/shared/models/form/user_form.dart';
import 'package:painel_cunsulta/shared/repositories/api/helpers/request_state.dart';
import 'package:painel_cunsulta/shared/repositories/api/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = UserControllerBase with _$UserController;

abstract class UserControllerBase with Store {
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerConfirmPassword =
      TextEditingController();

  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeConfirmPassword = FocusNode();

  @observable
  RequestState requestStateInitial = Initial();

  @observable
  RequestState requestStateCrud = Initial();

  @observable
  String errorName;

  @observable
  String errorEmail;

  @observable
  String errorPassword;

  @observable
  String errorConfirmPassword;

  @observable
  bool validatedAll = false;

  @observable
  String message = "";

  @observable
  ObservableList<UserDto> users;

  UserDto _user;

  UserRepository _userRepository = UserRepository();

  @action
  void validateName(String value) {
    if (value.trim().isEmpty) {
      errorName = error_required;
    } else {
      errorName = null;
    }
  }

  @action
  void validateEmail(String value) {
    if (value.trim().isEmpty) {
      errorEmail = error_required;
    } else {
      errorEmail = null;
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
  void validateConfirmPassword(String value) {
    if (value.trim().isEmpty) {
      errorConfirmPassword = error_required;
    } else {
      errorConfirmPassword = null;
    }
  }

  @action
  void validateAll(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) {
    validateName(name);
    validateEmail(email);
    validatePassword(password);
    validateConfirmPassword(confirmPassword);

    validatedAll = false;

    if (errorName == null &&
        errorEmail == null &&
        errorPassword == null &&
        errorConfirmPassword == null) {
      validatedAll = true;
    }
  }

  @action
  Future<void> getAllUsers() async {
    try {
      requestStateInitial = Loading();

      await Future.delayed(Duration(seconds: 1));

      users = ObservableList<UserDto>.of(
        await _userRepository.getAllUsers(),
      );

      requestStateInitial = Completed();
    } catch (e) {
      this.requestStateInitial = Error(
        error: e.toString().replaceAll("Exception:", ""),
      );
    }
  }

  @action
  Future<void> save() async {
    validateAll(
      textEditingControllerName.text.trim(),
      textEditingControllerEmail.text.trim(),
      textEditingControllerPassword.text.trim(),
      textEditingControllerConfirmPassword.text.trim(),
    );

    if (validatedAll) {
      try {
        requestStateCrud = Loading();

        await Future.delayed(Duration(seconds: 1));

        _user = await _userRepository.save(
          form: _getUser(
            name: textEditingControllerName.text.trim(),
            email: textEditingControllerEmail.text.trim(),
            password: textEditingControllerPassword.text.trim(),
          ),
        );

        message = success_insert_message;

        users.add(_user);

        _clearFields();

        requestStateCrud = Completed();
      } catch (e) {
        this.requestStateCrud = Error(
          error: e.toString().replaceAll("Exception:", ""),
        );
      }
    }
  }

  @action
  Future<void> delete(UserDto selectedUser) async {
    try {
      requestStateCrud = Loading();

      UserDto user = selectedUser;

      await Future.delayed(Duration(seconds: 1));

      await _userRepository.delete(userId: user.id);

      message = success_delete_message;

      users.removeWhere((element) => element.id == user.id);

      requestStateCrud = Completed();
    } catch (e) {
      this.requestStateCrud = Error(
        error: e.toString().replaceAll("Exception:", ""),
      );
    }
  }

  UserForm _getUser({
    String name,
    String email,
    String password,
  }) {
    UserForm form = UserForm();
    form.name = name;
    form.email = email;
    form.password = password;

    return form;
  }

  void _clearFields() {
    textEditingControllerName.text = "";
    textEditingControllerEmail.text = "";
    textEditingControllerPassword.text = "";
    textEditingControllerConfirmPassword.text = "";
  }
}
