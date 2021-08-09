import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobx/mobx.dart';
import 'package:painel_cunsulta/constants/colors.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/repositories/api/helpers/request_state.dart';
import 'package:painel_cunsulta/ui/dialogs/manager_dialogs.dart';
import 'package:painel_cunsulta/ui/home/home_page.dart';
import 'package:painel_cunsulta/ui/widgets/custom_text_field_primary.dart';
import 'package:painel_cunsulta/ui/widgets/primary_raised_button.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _loginController;

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    _loginController = LoginController();

    _disposers.add(
      reaction(
        (_) => _loginController.requestState,
        _authState,
      ),
    );
  }

  @override
  void dispose() {
    _disposers.forEach((disposer) => disposer());
    super.dispose();
  }

  void _authState(_) {
    if (_loginController.requestState is Error) {
      showAnimatedWarningAlertDialog(
        context: context,
        message: (_loginController.requestState as Error).error,
      );
    } else if (_loginController.requestState is Completed) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundSecondary,
      body: Container(
        child:
        //_buildLeftContent(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _buildLeftContent()),
            Expanded(
              flex: 2,
              child: _buildRightContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightContent() {
    return Opacity(
      opacity: 0.6,
      child: Image(
        image: AssetImage(asset_image_lunch),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLeftContent() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildLogo(),
          _buildForm(context),
          _buildForgotPassword(),
          _buildFooter()
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SafeArea(
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(asset_image_logo),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              label_button_login,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          _buildTextFieldUser(),
          _buildTextFieldPassword(),
          _buildButtonLogIn(),
        ],
      ),
    );
  }

  Widget _buildTextFieldUser() {
    return Observer(
      builder: (_) {
        return Container(
          margin: EdgeInsets.only(top: 16),
          child: CustomTextFormField(
            labelText: label_name_user,
            textEditingController: _loginController.textEditingControllerEmail,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            focusNode: _loginController.focusNodeEmail,
            onFieldSubmitted: (String value) {
              FocusScope.of(context)
                  .requestFocus(_loginController.focusNodePassword);
            },
            onChanged: _loginController.validateUser,
            errorText: _loginController.errorUser,
            enabled: !(_loginController.requestState is Loading),
          ),
        );
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return Observer(
      builder: (_) {
        return Container(
          margin: EdgeInsets.only(top: 16),
          child: CustomTextFormField(
            labelText: label_password,
            textEditingController:
                _loginController.textEditingControllerPassword,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.none,
            password: true,
            focusNode: _loginController.focusNodePassword,
            onFieldSubmitted: (String value) {},
            onChanged: _loginController.validatePassword,
            errorText: _loginController.errorPassword,
            enabled: !(_loginController.requestState is Loading),
          ),
        );
      },
    );
  }

  Widget _buildButtonLogIn() {
    return Observer(
      builder: (_) {
        return Container(
          margin: EdgeInsets.only(top: 24),
          child: PrimaryRaisedButton(
            leading: _loginController.requestState is Loading
                ? Container(
                    margin: EdgeInsets.only(right: 12),
                    child: SpinKitDualRing(
                      color: Colors.white,
                      size: 16,
                      lineWidth: 3,
                    ),
                  )
                : null,
            text: label_button_login,
            onPressed: _loginController.requestState is Loading
                ? null
                : _loginController.login,
          ),
        );
      },
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextButton(
            child: Text(
              label_forgot_password,
              style: TextStyle(fontSize: 16),
            ),
            //padding: EdgeInsets.only(left: 8, right: 8),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20, left: 8, right: 8),
          child: Text(
            label_title_footer,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Text(
            label_subtitle_footer,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
