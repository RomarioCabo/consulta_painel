import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_cunsulta/constants/colors.dart';

class CustomTextFieldIcon extends StatefulWidget {
  final String labelText;
  final String labelTextContent;
  final String labelTextError;
  final Function() onTap;

  CustomTextFieldIcon({
    @required this.labelText,
    this.labelTextContent = "",
    this.labelTextError,
    this.onTap,
  });

  @override
  _CustomTextFieldIconState createState() => _CustomTextFieldIconState();
}

class _CustomTextFieldIconState extends State<CustomTextFieldIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLabelTitle(),
          _buildContentLabel(),
          _buildErrorMessage(),
        ],
      ),
    );
  }

  Widget _buildLabelTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Text(
        widget.labelText,
        textAlign: TextAlign.start,
        style: styleTextField,
      ),
    );
  }

  Widget _buildContentLabel() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.labelTextError == null
                    ? Colors.grey[500]
                    : Theme.of(context).errorColor,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: Text(widget.labelTextContent),
          ),
        ),
        InkWell(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.grey[350],
              border: Border.all(
                color: widget.labelTextError == null
                    ? Colors.grey[500]
                    : Theme.of(context).errorColor,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child:  Icon(Icons.more_horiz),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    if (widget.labelTextError == null) {
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Text(
          widget.labelTextError,
          style: TextStyle(
            color: Theme.of(context).errorColor,
            fontSize: 14,
          ),
        ),
      );
    }
  }
}
