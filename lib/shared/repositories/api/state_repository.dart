import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:painel_cunsulta/shared/models/dto/state_dto.dart';
import 'package:painel_cunsulta/shared/models/form/state_form.dart';

import 'helpers/api_base_helper.dart';

class StateRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<StateDto> save({
    @required StateForm form,
  }) async {
    try {
      final response = await _helper.post(
        url: 'state/save',
        body: form.toJson(),
      );

      return StateDto.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<StateDto> put({
    @required int id,
    @required StateForm form,
  }) async {
    try {
      final response = await _helper.put(
        url: 'state/update',
        body: form.toJson(),
        pathVariable: id.toString(),
      );

      return StateDto.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete({@required int id}) async {
    try {
      await _helper.delete(
        url: 'state/delete',
        pathVariable: id.toString(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<StateDto>> getAllStates() async {
    try {
      final response = await _helper.get(
        url: 'state',
      );

      return List<StateDto>.from(
        response.map((item) => StateDto.fromJson(item)),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
