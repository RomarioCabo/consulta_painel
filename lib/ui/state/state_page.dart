import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobx/mobx.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/models/dto/state_dto.dart';
import 'package:painel_cunsulta/shared/repositories/api/helpers/request_state.dart';
import 'package:painel_cunsulta/ui/dialogs/manager_dialogs.dart';
import 'package:painel_cunsulta/ui/state/state_controller.dart';
import 'package:painel_cunsulta/ui/tiles/item_tile_state.dart';
import 'package:painel_cunsulta/ui/widgets/custom_animated_builder.dart';
import 'package:painel_cunsulta/ui/widgets/custom_text_field_icon.dart';
import 'package:painel_cunsulta/ui/widgets/custom_text_field_primary.dart';
import 'package:painel_cunsulta/ui/widgets/load.dart';
import 'package:painel_cunsulta/ui/widgets/primary_raised_button.dart';

class StatePage extends StatefulWidget {
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> with TickerProviderStateMixin {
  StateController _stateController;

  AnimationController _animationController;
  Animation<double> _opacity;

  ScrollController _scrollController;

  /// Reactions
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.000,
          1.000,
          curve: Curves.easeIn,
        ),
      ),
    );

    _scrollController = ScrollController();

    _stateController = StateController();
    _stateController.getAllStates();

    /// Reações
    _disposers.add(
      reaction(
        (_) => _stateController.requestStateInitial,
        _startAnimation,
      ),
    );

    _disposers.add(
      reaction(
        (_) => _stateController.requestStateSave,
        _stateSave,
      ),
    );

    _disposers.add(
      reaction(
        (_) => _stateController.requestStateUpdate,
        _stateUpdate,
      ),
    );
  }

  @override
  void dispose() {
    _disposers.forEach((disposer) => disposer());
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation(_) {
    if (_stateController.requestStateInitial is Completed) {
      _animationController.value = 0;
      _animationController.duration = Duration(milliseconds: 500);
      _animationController.forward();
    }
  }

  void _stateSave(_) {
    if (_stateController.requestStateSave is Completed) {
      showAnimatedSuccessAlertDialog(
        context: context,
        message: _stateController.message,
      );
    } else if (_stateController.requestStateSave is Error) {
      showAnimatedWarningAlertDialog(
        context: context,
        message: (_stateController.requestStateSave as Error).error,
      );
    }
  }

  void _stateUpdate(_) {
    if (_stateController.requestStateUpdate is Completed) {
      showAnimatedSuccessAlertDialog(
        context: context,
        message: _stateController.message,
      );
    } else if (_stateController.requestStateUpdate is Error) {
      showAnimatedWarningAlertDialog(
        context: context,
        message: (_stateController.requestStateUpdate as Error).error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: _bodyContent(),
          ),
        ),
      ),
    );
  }

  Widget _bodyContent() {
    return Observer(
      builder: (_) {
        if (_stateController.requestStateInitial is Loading) {
          return Load();
        } else {
          return _buildFields();
        }
      },
    );
  }

  Widget _buildFields() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(32),
        child: CustomAnimatedBuilder(
          animationController: _animationController,
          opacity: _opacity,
          contentChild: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildRowNameAndAcronym(),
              _buildRowCapitalAndGentle(),
              _buildRowTerritorialAreaAndTotalCounties(),
              _buildRowTotalPopulationAndDemographicDensity(),
              _buildRowIdhAndBorderingTerritory(),
              _buildRowPibAndNaturalAspects(),
              _buildRowEconomicActivitiesAndRegion(),
              CustomTextFieldIcon(
                labelText: text_field_path_image,
                labelTextContent: _stateController.imageName,
                labelTextError: _stateController.errorImage,
                onTap: () {
                  _stateController.getImage();
                },
              ),
              _buildRowButtons(),
              _buildTitleTable(),
              _buildContentTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowNameAndAcronym() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTextFieldName(),
          ),
          Expanded(
            child: _buildTextFieldAcronym(),
          ),
        ],
      ),
    );
  }

  Widget _buildRowTerritorialAreaAndTotalCounties() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTextFieldTerritorialArea(),
          ),
          Expanded(
            child: _buildTextFieldTotalCounties(),
          ),
        ],
      ),
    );
  }

  Widget _buildRowTotalPopulationAndDemographicDensity() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTextFieldTotalPopulation(),
          ),
          Expanded(
            child: _buildTextFieldDemographicDensity(),
          ),
        ],
      ),
    );
  }

  Widget _buildRowIdhAndBorderingTerritory() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTextFieldIdh(),
          ),
          Expanded(
            child: _buildTextFieldBorderingTerritory(),
          ),
        ],
      ),
    );
  }

  Widget _buildRowPibAndNaturalAspects() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTextFieldPib(),
          ),
          Expanded(
            child: _buildTextFieldNaturalAspects(),
          ),
        ],
      ),
    );
  }

  Widget _buildRowEconomicActivitiesAndRegion() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTextFieldEconomicActivities(),
          ),
          Expanded(
            child: _buildTextFieldRegion(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldName() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: text_field_name_state,
        textEditingController: _stateController.textEditingControllerName,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.none,
        focusNode: _stateController.focusNodeName,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeAcronym);
        },
        onChanged: _stateController.validateName,
        errorText: _stateController.errorName,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldAcronym() {
    return Container(
      child: CustomTextFormField(
        labelText: text_field_acronym_state,
        textEditingController: _stateController.textEditingControllerAcronym,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeAcronym,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeCapital);
        },
        onChanged: _stateController.validateAcronym,
        errorText: _stateController.errorAcronym,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildRowCapitalAndGentle() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTextFieldCapital(),
          ),
          Expanded(
            child: _buildTextFieldGentle(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldCapital() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: text_field_capital,
        textEditingController: _stateController.textEditingControllerCapital,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeCapital,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_stateController.focusNodeGentle);
        },
        onChanged: _stateController.validateCapital,
        errorText: _stateController.errorCapital,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldGentle() {
    return Container(
      child: CustomTextFormField(
        labelText: text_field_gentle,
        textEditingController: _stateController.textEditingControllerGentle,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeGentle,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeTerritorialArea);
        },
        onChanged: _stateController.validateGentle,
        errorText: _stateController.errorGentle,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldTerritorialArea() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: text_field_territorial_area,
        textEditingController:
            _stateController.textEditingControllerTerritorialArea,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeTerritorialArea,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeTotalCounties);
        },
        onChanged: _stateController.validateTerritorialArea,
        errorText: _stateController.errorTerritorialArea,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldTotalCounties() {
    return Container(
      child: CustomTextFormField(
        labelText: text_field_total_counties,
        textEditingController:
            _stateController.textEditingControllerTotalCounties,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeTotalCounties,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeTotalPopulation);
        },
        onChanged: _stateController.validateTotalCounties,
        errorText: _stateController.errorTotalCounties,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldTotalPopulation() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: text_field_total_population,
        textEditingController:
            _stateController.textEditingControllerTotalPopulation,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeTotalPopulation,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeDemographicDensity);
        },
        onChanged: _stateController.validateTotalPopulation,
        errorText: _stateController.errorTotalPopulation,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldDemographicDensity() {
    return Container(
      child: CustomTextFormField(
        labelText: text_field_demographic_density,
        textEditingController:
            _stateController.textEditingControllerDemographicDensity,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeDemographicDensity,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_stateController.focusNodeIdh);
        },
        onChanged: _stateController.validateDemographicDensity,
        errorText: _stateController.errorDemographicDensity,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldIdh() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: text_field_idh,
        textEditingController: _stateController.textEditingControllerIdh,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeIdh,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeBorderingTerritory);
        },
        onChanged: _stateController.validateIdh,
        errorText: _stateController.errorIdh,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldBorderingTerritory() {
    return Container(
      child: CustomTextFormField(
        labelText: text_field_bordering_territory,
        textEditingController:
            _stateController.textEditingControllerBorderingTerritory,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeBorderingTerritory,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_stateController.focusNodePib);
        },
        onChanged: _stateController.validateBorderingTerritory,
        errorText: _stateController.errorBorderingTerritory,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldPib() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: text_field_pib,
        textEditingController: _stateController.textEditingControllerPib,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodePib,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeNaturalAspects);
        },
        onChanged: _stateController.validatePib,
        errorText: _stateController.errorPib,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldNaturalAspects() {
    return Container(
      child: CustomTextFormField(
        labelText: text_field_natural_aspects,
        textEditingController:
            _stateController.textEditingControllerNaturalAspects,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeNaturalAspects,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeEconomicActivities);
        },
        onChanged: _stateController.validateNaturalAspects,
        errorText: _stateController.errorNaturalAspects,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldEconomicActivities() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: text_field_economic_activities,
        textEditingController:
            _stateController.textEditingControllerEconomicActivities,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeEconomicActivities,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_stateController.focusNodeRegion);
        },
        onChanged: _stateController.validateEconomicActivities,
        errorText: _stateController.errorEconomicActivities,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  Widget _buildTextFieldRegion() {
    return Container(
      child: CustomTextFormField(
        labelText: text_field_region,
        textEditingController: _stateController.textEditingControllerRegion,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        focusNode: _stateController.focusNodeRegion,
        onFieldSubmitted: (_) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeCuriosity);
        },
        onChanged: _stateController.validateRegion,
        errorText: _stateController.errorRegion,
        enabled: !(_enableTextFields()),
      ),
    );
  }

  bool _enableTextFields() {
    return _stateController.requestStateSave is Loading ||
        _stateController.requestStateUpdate is Loading;
  }

  Widget _buildRowButtons() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(child: _buttonSave()),
          Expanded(child: _buttonUpdate()),
        ],
      ),
    );
  }

  Widget _buttonSave() {
    return Container(
      padding: EdgeInsets.only(right: 12),
      child: PrimaryRaisedButton(
        leading: _stateController.requestStateSave is Loading
            ? Container(
                margin: EdgeInsets.only(right: 12),
                child: SpinKitDualRing(
                  color: Colors.white,
                  size: 16,
                  lineWidth: 3,
                ),
              )
            : null,
        text: label_button_save,
        onPressed: _enableSave(),
      ),
    );
  }

  Function _enableSave() {
    if (_stateController.requestStateSave is Loading ||
        _stateController.requestStateUpdate is Loading) {
      return null;
    } else {
      return () {
        _stateController.save();
      };
    }
  }

  Widget _buttonUpdate() {
    return Container(
      padding: EdgeInsets.only(left: 4),
      child: PrimaryRaisedButton(
        leading: _stateController.requestStateUpdate is Loading
            ? Container(
                margin: EdgeInsets.only(right: 12),
                child: SpinKitDualRing(
                  color: Colors.white,
                  size: 16,
                  lineWidth: 3,
                ),
              )
            : null,
        text: label_button_update,
        onPressed: _enableUpdate(),
      ),
    );
  }

  Function _enableUpdate() {
    if (_stateController.requestStateSave is Loading ||
        _stateController.requestStateUpdate is Loading) {
      return null;
    } else {
      return () {};
    }
  }

  Widget _buildTitleTable() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(),
          _buildContentTitleTable(),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildContentTitleTable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: Text(label_table_column_cod_state),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Text(label_table_column_name_state),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(label_table_column_acronym_state),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(label_table_column_flag_state,
                textAlign: TextAlign.center),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(label_table_column_actions_state),
          ),
        ),
      ],
    );
  }

  Widget _buildContentTable() {
    if (_stateController.states == null) {
      return Container();
    } else {
      return Container(
        height: 600,
        child: ListView.builder(
          itemCount: _stateController.states.length,
          itemBuilder: (context, index) {
            return ItemTileState(
              item: _stateController.states[index],
              onPressedEdit: () {},
              onPressedDelete: () {
                _openConfirmDialog(_stateController.states[index]);
              },
            );
          },
        ),
      );
    }
  }

  void _openConfirmDialog(StateDto selectedUser) {
    showAnimatedConfirmAlertDialog(
      context: context,
      message: question_message,
      function: () {},
    );
  }
}
