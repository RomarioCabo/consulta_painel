import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:painel_cunsulta/constants/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final bool password;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final Function(String) onFieldSubmitted;
  final Function(String) onChanged;
  final String errorText;
  final int maxLines;
  final bool enabled;
  final bool small;
  final double width;
  final bool containsTextInputFormatter;

  CustomTextFormField({
    this.labelText,
    @required this.focusNode,
    @required this.textEditingController,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.password = false,
    this.onFieldSubmitted,
    this.onChanged,
    this.errorText,
    this.maxLines = 1,
    this.enabled = true,
    this.small = false,
    this.width,
    this.containsTextInputFormatter = false,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    if (widget.focusNode != null) {
      widget.focusNode.addListener(_focusListener);
    }
  }

  @override
  void dispose() {
    if (widget.focusNode != null) {
      widget.focusNode.removeListener(_focusListener);
    }

    super.dispose();
  }

  void _focusListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.labelText == null
            ? Container()
            : Text(
                widget.labelText,
                style: styleTextField,
              ),
        Container(
          height: widget.small ? 40 : null,
          width: widget.width,
          margin: EdgeInsets.only(top: widget.labelText == null ? 0 : 8),
          child: TextFormField(
            inputFormatters: widget.containsTextInputFormatter
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            decoration: InputDecoration(
              fillColor:
                  widget.enabled ? Colors.transparent : colorTextFieldDisabled,
              filled: true,
              errorText: widget.errorText != null && widget.small
                  ? null
                  : widget.errorText,
              errorMaxLines: 2,
              errorStyle:
                  TextStyle(color: Theme.of(context).errorColor, fontSize: 14),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorTextField, width: 0.8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.errorText != null && widget.small
                        ? Theme.of(context).errorColor
                        : colorTextField,
                    width: 0.8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.errorText != null && widget.small
                        ? Theme.of(context).errorColor
                        : Theme.of(context).primaryColor,
                    width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).errorColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 1.5),
              ),
              contentPadding: EdgeInsets.only(
                  top: widget.small ? 0 : 16,
                  bottom: widget.small ? 0 : 16,
                  left: widget.small ? 12 : 16,
                  right: widget.small ? 12 : 16),
              suffixIcon: !widget.password
                  ? null
                  : IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).textTheme.bodyText2.color,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
            ),
            autovalidateMode: AutovalidateMode.disabled,
            style: Theme.of(context).textTheme.bodyText2,
            obscureText: widget.password && _obscurePassword,
            controller: widget.textEditingController,
            onFieldSubmitted: widget.onFieldSubmitted,
            //validator: widget.validator,
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            cursorColor: Theme.of(context).primaryColor,
            maxLines: widget.maxLines,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
          ),
        ),
        widget.errorText == null || widget.errorText.isEmpty || !widget.small
            ? Container()
            : Container(
                padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Text(
                  widget.errorText,
                  style: TextStyle(
                      color: Theme.of(context).errorColor, fontSize: 14),
                ),
              )
      ],
    );
  }
}
