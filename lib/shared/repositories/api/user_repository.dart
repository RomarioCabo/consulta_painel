import 'package:flutter/cupertino.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:painel_cunsulta/shared/models/form/user_form.dart';

import 'helpers/api_base_helper.dart';

class UserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<UserDto> save({
    @required UserForm form,
  }) async {
    try {
      final response = await _helper.post(
        url: 'user/save',
        body: form.toJson(),
      );

      return UserDto.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserDto> put({
    @required UserForm form,
    @required int userId
  }) async {
    try {
      final response = await _helper.put(
        url: 'user/update',
        body: form.toJson(),
        pathVariable: userId.toString(),
      );

      return UserDto.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete({@required int userId}) async {
    try {
      await _helper.delete(
        url: 'user/delete',
        pathVariable: userId.toString(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserDto>> getAllUsers() async {
    try {
      final response = await _helper.get(
        url: 'user',
      );

      return List<UserDto>.from(
        response.map((item) => UserDto.fromJson(item)),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
