import 'package:flutter/cupertino.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:mobx/mobx.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/models/dto/state_dto.dart';
import 'package:painel_cunsulta/shared/models/form/state_form.dart';
import 'package:painel_cunsulta/shared/repositories/api/helpers/request_state.dart';
import 'package:painel_cunsulta/shared/repositories/api/state_repository.dart';

part 'state_controller.g.dart';

class StateController = StateControllerBase with _$StateController;

abstract class StateControllerBase with Store {
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerAcronym = TextEditingController();

  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeAcronym = FocusNode();

  @observable
  RequestState requestStateInitial = Initial();

  @observable
  RequestState requestStateSave = Initial();

  @observable
  RequestState requestStateUpdate = Initial();

  @observable
  String errorName;

  @observable
  String errorAcronym;

  @observable
  String errorImage;

  @observable
  bool validateAll = false;

  @observable
  String message = "";

  @observable
  String imageName = "";

  String _fileInBase64;

  int _selectedIdState;
  int _index;

  @observable
  ObservableList<StateDto> states;

  StateDto _state;

  StateRepository _stateRepository = StateRepository();

  @action
  void validateName(String value) {
    if (value.trim().isEmpty) {
      errorName = error_required;
    } else {
      errorName = null;
    }
  }

  @action
  void validateAcronym(String value) {
    if (value.trim().isEmpty) {
      errorAcronym = error_required;
    } else {
      errorAcronym = null;
    }
  }

  @action
  void validateImage(String value) {
    if (value == null) {
      errorImage = error_required;
    } else {
      errorImage = null;
    }
  }

  @action
  void validatedAll(
    String name,
    String acronym,
    String image,
  ) {
    validateName(name);
    validateAcronym(acronym);
    validateImage(image);

    validateAll = false;

    if (errorName == null && errorAcronym == null && errorImage == null) {
      validateAll = true;
    }
  }

  @action
  Future<void> getAllStates() async {
    try {
      requestStateInitial = Loading();

      await Future.delayed(Duration(seconds: 1));

      states = ObservableList<StateDto>.of(
        await _stateRepository.getAllStates(),
      );

      requestStateInitial = Completed();
    } catch (e) {
      this.requestStateInitial = Error(
        error: e.toString().replaceAll("Exception:", ""),
      );
    }
  }

  @action
  Future<void> getImage() async {
    try {
      MediaInfo imageSelected = await ImagePickerWeb.getImageInfo;

      if (imageSelected != null) {
        imageName = imageSelected.fileName;
        _fileInBase64 = imageSelected.base64WithScheme;

        errorImage = null;
      }
    } catch (e) {
      print(e);

      imageName = "Error ao selecionar essa imagem!";
    }
  }

  @action
  Future<void> save() async {
    validatedAll(
      textEditingControllerName.text,
      textEditingControllerAcronym.text,
      imageName,
    );

    if (validateAll) {
      try {
        requestStateSave = Loading();

        await Future.delayed(Duration(seconds: 1));

        _state = await _stateRepository.save(
          form: _getState(
            name: textEditingControllerName.text.trim(),
            acronym: textEditingControllerAcronym.text.trim(),
            fileInBase64: _fileInBase64,
          ),
        );

        message = success_insert_message;

        states.add(_state);

        _clearFields();

        requestStateSave = Completed();
      } catch (e) {
        this.requestStateSave = Error(
          error: e.toString().replaceAll("Exception:", ""),
        );
      }
    }
  }

  StateForm _getState({
    @required String name,
    @required String acronym,
    @required String fileInBase64,
  }) {
    StateForm form = StateForm();
    form.name = name;
    form.acronym = acronym;
    form.fileInBase64 = fileInBase64;

    return form;
  }

  void _clearFields() {
    textEditingControllerName.text = "";
    textEditingControllerAcronym.text = "";
    imageName = "";
  }
}
