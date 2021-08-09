import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:painel_cunsulta/shared/models/enum/user_profile.dart';
import 'package:painel_cunsulta/shared/models/form/user_form.dart';
import 'package:painel_cunsulta/shared/repositories/api/helpers/request_state.dart';
import 'package:painel_cunsulta/shared/repositories/api/user_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:painel_cunsulta/shared/repositories/local_storage_shared_preferences/local_storage_shared_preferences.dart';

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

  int _selectedIdUser;
  int _selectedIdProfile;
  int _index;

  @observable
  ObservableList<UserDto> users;

  UserDto _user;

  UserDto _userDto;

  @observable
  UserProfile userProfile = UserProfile.ROLE_ADMIN;

  LocalStorageSharedPreferences _localStorageSharedPreferences =
      GetIt.I<LocalStorageSharedPreferences>();

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
      if (value == textEditingControllerPassword.text) {
        errorConfirmPassword = null;
      } else {
        errorConfirmPassword = alert_message_password;
      }
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
  void setCurrentUser() {
    _userDto = _localStorageSharedPreferences.getUser();
  }

  @action
  Future<void> getAllUsers() async {
    try {
      requestStateInitial = Loading();

      await Future.delayed(Duration(seconds: 1));

      users = ObservableList<UserDto>.of(
        await _userRepository.getAllUsers(
          authorization: _userDto.token,
        ),
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
          authorization: _userDto.token,
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

      await _userRepository.delete(
        authorization: _userDto.token,
        userId: user.id,
      );

      message = success_delete_message;

      users.removeWhere((element) => element.id == user.id);

      requestStateCrud = Completed();
    } catch (e) {
      this.requestStateCrud = Error(
        error: e.toString().replaceAll("Exception:", ""),
      );
    }
  }

  @action
  void setFields(UserDto selectedUser, int index) {
    textEditingControllerName.text = selectedUser.name;
    textEditingControllerEmail.text = selectedUser.email;

    _selectedIdUser = selectedUser.id;
    _selectedIdProfile = selectedUser.profile.id;
    userProfile = selectedUser.profile.codProfile == 1
        ? UserProfile.ROLE_ADMIN
        : UserProfile.ROLE_CLIENT;
    _index = index;
  }

  @action
  Future<void> update() async {
    try {
      if (_selectedIdUser == null) {
        this.requestStateCrud = Error(
          error: alert_message_update,
        );

        return;
      }

      requestStateCrud = Loading();

      validateName(textEditingControllerName.text.trim());
      validateEmail(textEditingControllerEmail.text.trim());

      if (errorName == null && errorEmail == null) {
        _user = await _userRepository.put(
          authorization: _userDto.token,
          form: _getUser(
            name: textEditingControllerName.text.trim(),
            email: textEditingControllerEmail.text.trim(),
            password: _getPassword(textEditingControllerPassword.text.trim()),
          ),
          userId: _selectedIdUser,
          profileId: _selectedIdProfile,
        );

        message = success_update_message;

        users[_index].name = _user.name;
        users[_index].email = _user.email;

        _selectedIdUser = null;
        _index = null;

        _clearFields();
      }

      requestStateCrud = Completed();
    } catch (e, stackTrace) {
      print(stackTrace);

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
    form.name = name.isEmpty ? null : name;
    form.email = email.isEmpty ? null : email;
    form.password = password.isEmpty ? null : password;
    form.codProfile = userProfile == UserProfile.ROLE_ADMIN ? 1 : 2;

    return form;
  }

  void _clearFields() {
    textEditingControllerName.text = "";
    textEditingControllerEmail.text = "";
    textEditingControllerPassword.text = "";
    textEditingControllerConfirmPassword.text = "";
    userProfile = UserProfile.ROLE_ADMIN;
  }

  String _getPassword(String password) {
    return textEditingControllerPassword.text == null
        ? null
        : textEditingControllerPassword.text;
  }
}
