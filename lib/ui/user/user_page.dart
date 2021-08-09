import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:painel_cunsulta/constants/colors.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:painel_cunsulta/shared/models/enum/user_profile.dart';
import 'package:painel_cunsulta/shared/repositories/api/helpers/request_state.dart';
import 'package:painel_cunsulta/ui/dialogs/manager_dialogs.dart';
import 'package:painel_cunsulta/ui/tiles/item_tile_user.dart';
import 'package:painel_cunsulta/ui/user/user_controller.dart';
import 'package:painel_cunsulta/ui/widgets/custom_animated_builder.dart';
import 'package:painel_cunsulta/ui/widgets/custom_text_field_primary.dart';
import 'package:painel_cunsulta/ui/widgets/load.dart';
import 'package:painel_cunsulta/ui/widgets/primary_raised_button.dart';
import 'package:mobx/mobx.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
  UserController _userController;

  AnimationController _animationController;
  Animation<double> _opacity;

  ScrollController _scrollControllerPrincipal;
  ScrollController _scrollControllerListView;

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

    _scrollControllerPrincipal = ScrollController();
    _scrollControllerListView = ScrollController();

    _userController = UserController();
    _userController.setCurrentUser();

    _userController.getAllUsers();

    /// Reações
    _disposers.add(
      reaction(
        (_) => _userController.requestStateInitial,
        _startAnimation,
      ),
    );

    _disposers.add(
      reaction(
        (_) => _userController.requestStateCrud,
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
    if (_userController.requestStateInitial is Completed) {
      _animationController.value = 0;
      _animationController.duration = Duration(milliseconds: 500);
      _animationController.forward();
    }
  }

  void _stateSave(_) {
    if (_userController.requestStateCrud is Completed) {
      showAnimatedSuccessAlertDialog(
        context: context,
        message: _userController.message,
      );
    } else if (_userController.requestStateCrud is Error) {
      showAnimatedWarningAlertDialog(
        context: context,
        message: (_userController.requestStateCrud as Error).error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: _bodyContent(),
        ),
      ),
    );
  }

  Widget _bodyContent() {
    return Observer(
      builder: (_) {
        if (_userController.requestStateInitial is Loading) {
          return Load();
        } else {
          return _buildFields();
        }
      },
    );
  }

  Widget _buildFields() {
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollControllerPrincipal,
      child: SingleChildScrollView(
        controller: _scrollControllerPrincipal,
        child: Container(
          margin: EdgeInsets.only(top: 52, left: 152, right: 152, bottom: 52),
          child: CustomAnimatedBuilder(
            animationController: _animationController,
            opacity: _opacity,
            contentChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextFieldName(),
                _buildTextFieldEMail(),
                _buildRowChangePassword(),
                _buildRowRadioButtons(),
                _buildRowButtons(),
                _buildTitleTable(),
                _buildContentTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldName() {
    return Container(
      child: CustomTextFormField(
        labelText: label_text_field_name,
        textEditingController: _userController.textEditingControllerName,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.none,
        focusNode: _userController.focusNodeName,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_userController.focusNodeEmail);
        },
        onChanged: _userController.validateName,
        errorText: _userController.errorName,
        enabled: !(_userController.requestStateCrud is Loading),
      ),
    );
  }

  Widget _buildTextFieldEMail() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: CustomTextFormField(
        labelText: label_text_field_email,
        textEditingController: _userController.textEditingControllerEmail,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.none,
        focusNode: _userController.focusNodeEmail,
        onFieldSubmitted: (String value) {
          FocusScope.of(context)
              .requestFocus(_userController.focusNodePassword);
        },
        onChanged: _userController.validateEmail,
        errorText: _userController.errorEmail,
        enabled: !(_userController.requestStateCrud is Loading),
      ),
    );
  }

  Widget _buildRowChangePassword() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTextFieldPassword(),
          ),
          Expanded(
            child: _buildTextFieldConfirmPassword(),
          ),
        ],
      ),
    );
  }

  Widget _buildRowRadioButtons() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Acesso ao painel?",
            style: styleTextField,
          ),
          Container(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile<UserProfile>(
                    title: Text(
                      "Sim",
                      style: TextStyle(
                        color: colorTextField,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    value: UserProfile.ROLE_ADMIN,
                    groupValue: _userController.userProfile,
                    onChanged: (UserProfile value) {
                      _userController.userProfile = value;
                    },
                  ),
                ),
                Container(
                  width: 14,
                ),
                Expanded(
                  child: RadioListTile<UserProfile>(
                    title: Text(
                      "Não",
                      style: TextStyle(
                        color: colorTextField,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    value: UserProfile.ROLE_CLIENT,
                    groupValue: _userController.userProfile,
                    onChanged: (UserProfile value) {
                      _userController.userProfile = value;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldPassword() {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: CustomTextFormField(
        labelText: label_text_field_password,
        textEditingController: _userController.textEditingControllerPassword,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.none,
        password: true,
        focusNode: _userController.focusNodePassword,
        onFieldSubmitted: (String value) {
          FocusScope.of(context)
              .requestFocus(_userController.focusNodeConfirmPassword);
        },
        onChanged: _userController.validatePassword,
        errorText: _userController.errorPassword,
        enabled: !(_userController.requestStateCrud is Loading),
      ),
    );
  }

  Widget _buildTextFieldConfirmPassword() {
    return Container(
      child: CustomTextFormField(
        labelText: label_text_field_confirm_password,
        textEditingController:
            _userController.textEditingControllerConfirmPassword,
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.none,
        password: true,
        focusNode: _userController.focusNodeConfirmPassword,
        onFieldSubmitted: null,
        onChanged: _userController.validateConfirmPassword,
        errorText: _userController.errorConfirmPassword,
        enabled: !(_userController.requestStateCrud is Loading),
      ),
    );
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
        leading: _userController.requestStateCrud is Loading
            ? Container(
                child: SpinKitDualRing(
                  color: Colors.white,
                  size: 16,
                  lineWidth: 3,
                ),
              )
            : null,
        text: label_button_save,
        onPressed: _userController.requestStateCrud is Loading
            ? null
            : _userController.save,
      ),
    );
  }

  Widget _buttonUpdate() {
    return Container(
      padding: EdgeInsets.only(left: 4),
      child: PrimaryRaisedButton(
        leading: _userController.requestStateCrud is Loading
            ? Container(
                child: SpinKitDualRing(
                  color: Colors.white,
                  size: 16,
                  lineWidth: 3,
                ),
              )
            : null,
        text: label_button_update,
        onPressed: _userController.requestStateCrud is Loading
            ? null
            : _userController.update,
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
            child: Text(label_table_column_cod),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Text(label_table_column_name),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Text(label_table_column_email),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Text(label_table_column_actions),
          ),
        ),
      ],
    );
  }

  Widget _buildContentTable() {
    if (_userController.users == null) {
      return Container();
    } else {
      return Container(
        height: 400,
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollControllerListView,
          child: ListView.builder(
            controller: _scrollControllerListView,
            itemCount: _userController.users.length,
            itemBuilder: (context, index) {
              return ItemTileUser(
                item: _userController.users[index],
                onPressedEdit: () {
                  _userController.setFields(
                    _userController.users[index],
                    index,
                  );
                },
                onPressedDelete: () {
                  _openConfirmDialog(_userController.users[index]);
                },
              );
            },
          ),
        ),
      );
    }
  }

  void _openConfirmDialog(UserDto selectedUser) {
    showAnimatedConfirmAlertDialog(
      context: context,
      message: question_message,
      function: () {
        _userController.delete(selectedUser);
      },
    );
  }
}
