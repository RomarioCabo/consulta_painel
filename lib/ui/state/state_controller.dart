import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
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
  TextEditingController textEditingControllerCapital = TextEditingController();
  TextEditingController textEditingControllerGentle = TextEditingController();
  TextEditingController textEditingControllerTerritorialArea =
      TextEditingController();
  TextEditingController textEditingControllerTotalCounties =
      TextEditingController();
  TextEditingController textEditingControllerTotalPopulation =
      TextEditingController();
  TextEditingController textEditingControllerDemographicDensity =
      TextEditingController();
  TextEditingController textEditingControllerIdh = MoneyMaskedTextController(
    precision: 3,
    decimalSeparator: ".",
    thousandSeparator: "",
  );
  TextEditingController textEditingControllerBorderingTerritory =
      TextEditingController();
  TextEditingController textEditingControllerPib = TextEditingController();
  TextEditingController textEditingControllerNaturalAspects =
      TextEditingController();
  TextEditingController textEditingControllerEconomicActivities =
      TextEditingController();
  TextEditingController textEditingControllerCuriosity =
      TextEditingController();
  TextEditingController textEditingControllerRegion = TextEditingController();

  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeAcronym = FocusNode();
  FocusNode focusNodeCapital = FocusNode();
  FocusNode focusNodeGentle = FocusNode();
  FocusNode focusNodeTerritorialArea = FocusNode();
  FocusNode focusNodeTotalCounties = FocusNode();
  FocusNode focusNodeTotalPopulation = FocusNode();
  FocusNode focusNodeDemographicDensity = FocusNode();
  FocusNode focusNodeIdh = FocusNode();
  FocusNode focusNodeBorderingTerritory = FocusNode();
  FocusNode focusNodePib = FocusNode();
  FocusNode focusNodeNaturalAspects = FocusNode();
  FocusNode focusNodeEconomicActivities = FocusNode();
  FocusNode focusNodeCuriosity = FocusNode();
  FocusNode focusNodeRegion = FocusNode();

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
  String errorCapital;

  @observable
  String errorGentle;

  @observable
  String errorTerritorialArea;

  @observable
  String errorTotalCounties;

  @observable
  String errorTotalPopulation;

  @observable
  String errorDemographicDensity;

  @observable
  String errorIdh;

  @observable
  String errorBorderingTerritory;

  @observable
  String errorPib;

  @observable
  String errorNaturalAspects;

  @observable
  String errorEconomicActivities;

  @observable
  String errorRegion;

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
  void validateCapital(String value) {
    if (value == null) {
      errorCapital = error_required;
    } else {
      errorCapital = null;
    }
  }

  @action
  void validateGentle(String value) {
    if (value == null) {
      errorGentle = error_required;
    } else {
      errorGentle = null;
    }
  }

  @action
  void validateTerritorialArea(String value) {
    if (value == null) {
      errorTerritorialArea = error_required;
    } else {
      errorTerritorialArea = null;
    }
  }

  @action
  void validateTotalCounties(String value) {
    if (value == null) {
      errorTotalCounties = error_required;
    } else {
      errorTotalCounties = null;
    }
  }

  @action
  void validateTotalPopulation(String value) {
    if (value == null) {
      errorTotalPopulation = error_required;
    } else {
      errorTotalPopulation = null;
    }
  }

  @action
  void validateDemographicDensity(String value) {
    if (value == null) {
      errorDemographicDensity = error_required;
    } else {
      errorDemographicDensity = null;
    }
  }

  @action
  void validateIdh(String value) {
    if (value == null) {
      errorIdh = error_required;
    } else {
      errorIdh = null;
    }
  }

  @action
  void validateBorderingTerritory(String value) {
    if (value == null) {
      errorBorderingTerritory = error_required;
    } else {
      errorBorderingTerritory = null;
    }
  }

  @action
  void validatePib(String value) {
    if (value == null) {
      errorPib = error_required;
    } else {
      errorPib = null;
    }
  }

  @action
  void validateNaturalAspects(String value) {
    if (value == null) {
      errorNaturalAspects = error_required;
    } else {
      errorNaturalAspects = null;
    }
  }

  @action
  void validateEconomicActivities(String value) {
    if (value == null) {
      errorEconomicActivities = error_required;
    } else {
      errorEconomicActivities = null;
    }
  }

  @action
  void validateRegion(String value) {
    if (value == null) {
      errorRegion = error_required;
    } else {
      errorRegion = null;
    }
  }

  @action
  void validatedAll({
    @required String name,
    @required String acronym,
    @required String image,
    @required String capital,
    @required String gentle,
    @required String territorialArea,
    @required String totalCounties,
    @required String totalPopulation,
    @required String demographicDensity,
    @required String idh,
    @required String borderingTerritory,
    @required String pib,
    @required String naturalAspects,
    @required String economicActivities,
    @required String region,
  }) {
    validateName(name);
    validateAcronym(acronym);
    validateImage(image);
    validateCapital(capital);
    validateGentle(gentle);
    validateTerritorialArea(territorialArea);
    validateTotalCounties(totalCounties);
    validateTotalPopulation(totalPopulation);
    validateDemographicDensity(demographicDensity);
    validateIdh(idh);
    validateBorderingTerritory(borderingTerritory);
    validatePib(pib);
    validateNaturalAspects(naturalAspects);
    validateEconomicActivities(economicActivities);
    validateRegion(region);

    validateAll = false;

    if (errorName == null &&
        errorAcronym == null &&
        errorImage == null &&
        errorCapital == null &&
        errorGentle == null &&
        errorTerritorialArea == null &&
        errorTotalCounties == null &&
        errorTotalPopulation == null &&
        errorDemographicDensity == null &&
        errorIdh == null &&
        errorBorderingTerritory == null &&
        errorPib == null &&
        errorNaturalAspects == null &&
        errorEconomicActivities == null &&
        errorRegion == null) {
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
      name: textEditingControllerName.text.trim(),
      acronym: textEditingControllerAcronym.text.trim(),
      image: imageName,
      capital: textEditingControllerCapital.text.trim(),
      gentle: textEditingControllerGentle.text.trim(),
      territorialArea: textEditingControllerTerritorialArea.text.trim(),
      totalCounties: textEditingControllerTotalCounties.text.trim(),
      totalPopulation: textEditingControllerTotalPopulation.text.trim(),
      demographicDensity: textEditingControllerDemographicDensity.text.trim(),
      idh: textEditingControllerIdh.text.trim(),
      borderingTerritory: textEditingControllerBorderingTerritory.text.trim(),
      pib: textEditingControllerPib.text.trim(),
      naturalAspects: textEditingControllerNaturalAspects.text.trim(),
      economicActivities: textEditingControllerEconomicActivities.text.trim(),
      region: textEditingControllerRegion.text.trim(),
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
            capital: textEditingControllerCapital.text.trim(),
            gentle: textEditingControllerGentle.text.trim(),
            territorialArea: textEditingControllerTerritorialArea.text.trim(),
            totalCounties: textEditingControllerTotalCounties.text.trim(),
            totalPopulation: textEditingControllerTotalPopulation.text.trim(),
            demographicDensity:
                textEditingControllerDemographicDensity.text.trim(),
            idh: textEditingControllerIdh.text.trim(),
            borderingTerritory:
                textEditingControllerBorderingTerritory.text.trim(),
            pib: textEditingControllerPib.text.trim(),
            naturalAspects: textEditingControllerNaturalAspects.text.trim(),
            economicActivities:
                textEditingControllerEconomicActivities.text.trim(),
            region: textEditingControllerRegion.text.trim(),
            curiosity: textEditingControllerCuriosity.text.trim(),
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
    @required String capital,
    @required String gentle,
    @required String territorialArea,
    @required String totalCounties,
    @required String totalPopulation,
    @required String demographicDensity,
    @required String idh,
    @required String borderingTerritory,
    @required String pib,
    @required String naturalAspects,
    @required String economicActivities,
    @required String region,
    @required String curiosity,
  }) {
    StateForm form = StateForm();
    form.name = name;
    form.acronym = acronym;
    form.fileInBase64 = fileInBase64;
    form.capital = capital;
    form.gentle = gentle;
    form.territorialArea = int.parse(territorialArea);
    form.totalCounties = int.parse(totalCounties);
    form.totalPopulation = int.parse(totalPopulation);
    form.demographicDensity = double.parse(demographicDensity);
    form.idh = double.parse(idh);
    form.borderingTerritory = borderingTerritory;
    form.pib = double.parse(pib);
    form.naturalAspects = naturalAspects;
    form.economicActivities = economicActivities;
    form.region = region;
    form.curiosity = curiosity;

    return form;
  }

  void _clearFields() {
    textEditingControllerName.text = "";
    textEditingControllerAcronym.text = "";
    imageName = "";
    textEditingControllerCapital.text = "";
    textEditingControllerGentle.text = "";
    textEditingControllerTerritorialArea.text = "";
    textEditingControllerTotalCounties.text = "";
    textEditingControllerTotalPopulation.text = "";
    textEditingControllerDemographicDensity.text = "";
    textEditingControllerIdh.text = "";
    textEditingControllerBorderingTerritory.text = "";
    textEditingControllerPib.text = "";
    textEditingControllerNaturalAspects.text = "";
    textEditingControllerEconomicActivities.text = "";
    textEditingControllerRegion.text = "";
    textEditingControllerCuriosity.text = "";
  }
}
