import 'package:flutter/material.dart';
import 'package:painel_cunsulta/constants/colors.dart';

class PrimaryRaisedButton extends StatefulWidget {
  final String text;
  final Widget child;
  final Widget leading;
  final Widget trailing;
  final Function() onPressed;
  final double height;

  PrimaryRaisedButton(
      {Key key,
      this.text,
      this.child,
      this.leading,
      this.trailing,
      this.onPressed,
      this.height = 50})
      : super(key: key);

  @override
  PrimaryRaisedButtonState createState() => PrimaryRaisedButtonState();
}

class PrimaryRaisedButtonState extends State<PrimaryRaisedButton>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return colorPrimary;

                if (states.contains(MaterialState.disabled)) return colorPrimaryTransparent;

                return null; // Use the component's default.
              },
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.leading ?? Container(),
              Center(
                  child: widget.text != null
                      ? Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorTextButtonPrimary,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : widget.child ?? Container()),
              widget.trailing ?? Container()
            ],
          ),
          onPressed: widget.onPressed),
    );
  }
}
