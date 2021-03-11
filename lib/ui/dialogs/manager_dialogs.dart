import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showWarningAlertDialog({
  @required BuildContext context,
  @required String message,
}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "ok",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Atenção",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Text(
      message,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    ),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAnimatedWarningAlertDialog({
  @required BuildContext context,
  @required String message,
}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Atenção',
    desc: message,
    btnOkOnPress: () {},
    width: 500,
  )..show();
}

showAnimatedSuccessAlertDialog({
  @required BuildContext context,
  @required String message,
}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Sucesso',
    desc: message,
    btnOkOnPress: () {},
    width: 500,
  )..show();
}

showAnimatedConfirmAlertDialog({
  @required BuildContext context,
  @required String message,
  Function function,
}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    context: context,
    dialogType: DialogType.QUESTION,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Aviso',
    desc: message,
    btnOkOnPress: function,
    btnOkText: "Sim",
    btnOkColor: Colors.red,
    btnCancelOnPress: () {},
    btnCancelText: "Não",
    btnCancelColor: Color(0xFF00CA71),
    width: 500,
  )..show();
}
