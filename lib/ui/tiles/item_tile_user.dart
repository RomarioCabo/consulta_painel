import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';

class ItemTileUser extends StatefulWidget {
  final UserDto item;
  final Function() onPressedEdit;
  final Function() onPressedDelete;

  ItemTileUser({
    @required this.item,
    @required this.onPressedEdit,
    @required this.onPressedDelete,
  });

  @override
  _ItemTileUserState createState() => _ItemTileUserState();
}

class _ItemTileUserState extends State<ItemTileUser> {
  @override
  Widget build(BuildContext context) {
    return _buildTable();
  }

  Widget _buildTable() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildContentTable(),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildContentTable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: Text(widget.item.id.toString().padLeft(5, "0")),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Text(widget.item.name),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Text(widget.item.email),
          ),
        ),
        _buildActionsButtons(),
      ],
    );
  }

  Widget _buildActionsButtons() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: widget.onPressedEdit,
          ),
          widget.item.id == 1
              ? Container()
              : IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: widget.onPressedDelete,
                ),
        ],
      ),
    );
  }
}
