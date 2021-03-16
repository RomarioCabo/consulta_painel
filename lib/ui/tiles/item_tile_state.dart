import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_cunsulta/shared/models/dto/state_dto.dart';

class ItemTileState extends StatefulWidget {
  final StateDto item;
  final Function() onPressedEdit;
  final Function() onPressedDelete;

  ItemTileState({
    @required this.item,
    @required this.onPressedEdit,
    @required this.onPressedDelete,
  });

  @override
  _ItemTileStateState createState() => _ItemTileStateState();
}

class _ItemTileStateState extends State<ItemTileState> {
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            child: Text(widget.item.id.toString().padLeft(5, "0")),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Text(widget.item.name),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(widget.item.acronym),
          ),
        ),
        Expanded(
          child: _buildImage(),
        ),
        _buildActionsButtons(),
      ],
    );
  }

  Widget _buildActionsButtons() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: widget.onPressedEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onPressedDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (widget.item.urlImage == null) {
      return Container(
        width: 50,
        height: 60,
      );
    } else {
      return Image.network(
        widget.item.urlImage,
        width: 50,
        height: 60,
      );
    }
  }
}
