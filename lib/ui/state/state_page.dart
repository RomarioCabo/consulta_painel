import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        (_) => _stateController.requestStateCrud,
        _stateSave,
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
    if (_stateController.requestStateCrud is Completed) {
      showAnimatedSuccessAlertDialog(
        context: context,
        message: _stateController.message,
      );
    } else if (_stateController.requestStateCrud is Error) {
      showAnimatedWarningAlertDialog(
        context: context,
        message: (_stateController.requestStateCrud as Error).error,
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
            _buildRowState(),
            CustomTextFieldIcon(
              labelText: label_text_field_path_image,
              onTap: () {
                _stateController.getImage();
              },
            ),
            _buildRowSave(),
            _buildTitleTable(),
            _buildContentTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildRowState() {
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

  Widget _buildTextFieldName() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: label_text_field_name_state,
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
        enabled: !(_stateController.requestStateCrud is Loading),
      ),
    );
  }

  Widget _buildTextFieldAcronym() {
    return Container(
      child: CustomTextFormField(
        labelText: label_text_field_acronym_state,
        textEditingController: _stateController.textEditingControllerAcronym,
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.none,
        focusNode: _stateController.focusNodeAcronym,
        onFieldSubmitted: null,
        onChanged: _stateController.validateAcronym,
        errorText: _stateController.errorAcronym,
        enabled: !(_stateController.requestStateCrud is Loading),
      ),
    );
  }



  Widget _buildRowSave() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(child: Container()),
          Expanded(child: _buttonSave()),
        ],
      ),
    );
  }

  Widget _buttonSave() {
    return Container(
      padding: EdgeInsets.only(left: 12),
      child: PrimaryRaisedButton(
        leading: null,
        text: label_button_save,
        onPressed: _stateController.requestStateCrud is Loading ? null : () {},
      ),
    );
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
