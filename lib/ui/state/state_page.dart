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
        body: _bodyContent(),
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
    return Container(
      margin: EdgeInsets.all(32),
      child: CustomAnimatedBuilder(
        animationController: _animationController,
        opacity: _opacity,
        contentChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRowNameAndAcronym(),
            CustomTextFieldIcon(
              labelText: text_field_path_image,
              labelTextContent: _stateController.imageName,
              labelTextError: _stateController.errorImage,
              onTap: () {
                _stateController.getImage();
              },
            ),
            _buildRowCapitalAndGentle(),
            _buildRowButtons(),
            _buildTitleTable(),
            _buildContentTable(),
          ],
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

  Widget _buildTextFieldName() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: text_field_name_state,
        textEditingController: _stateController.textEditingControllerName,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.none,
        focusNode: _stateController.focusNodeName,
        onFieldSubmitted: (String value) {
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
        onFieldSubmitted: (String value) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeCapital);
        },
        onChanged: _stateController.validateAcronym,
        errorText: _stateController.errorAcronym,
        enabled: !(_enableTextFields()),
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
        onFieldSubmitted: (String value) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeCapital);
        },
        onChanged: _stateController.validateAcronym,
        errorText: _stateController.errorAcronym,
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
        onFieldSubmitted: (String value) {
          FocusScope.of(context)
              .requestFocus(_stateController.focusNodeCapital);
        },
        onChanged: _stateController.validateAcronym,
        errorText: _stateController.errorAcronym,
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
      return Expanded(
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
