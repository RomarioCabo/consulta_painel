import 'package:flutter/cupertino.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:mobx/mobx.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/models/dto/state_dto.dart';
import 'package:painel_cunsulta/shared/repositories/api/helpers/request_state.dart';
import 'package:painel_cunsulta/shared/repositories/api/state_repository.dart';

part 'state_controller.g.dart';

class StateController = StateControllerBase with _$StateController;

abstract class StateControllerBase with Store {
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerAcronym = TextEditingController();
  TextEditingController textEditingControllerImage = TextEditingController();

  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeAcronym = FocusNode();
  FocusNode focusNodeImage = FocusNode();

  @observable
  RequestState requestStateInitial = Initial();

  @observable
  RequestState requestStateCrud = Initial();

  @observable
  String errorName;

  @observable
  String errorAcronym;

  @observable
  bool validatedAll = false;

  @observable
  String message = "";

  int _selectedIdState;
  int _index;

  @observable
  ObservableList<StateDto> states;

  StateDto _state;

  var _imageSelected;

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
      _imageSelected = await ImagePickerWeb.getImageInfo;

      if (_imageSelected != null) {
        textEditingControllerImage.text = _imageSelected.fileName;
      }
    } catch (e) {

      this.requestStateCrud = Error(
        error: "Erro ao fazer upload da imagem",
      );
    }
  }

  @action
  Future<void> save() async {
    validateName(textEditingControllerName.text.trim());
    validateAcronym(textEditingControllerAcronym.text.trim());


  }
}
