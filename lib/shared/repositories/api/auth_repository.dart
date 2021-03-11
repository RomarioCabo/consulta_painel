import 'package:flutter/cupertino.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:painel_cunsulta/shared/models/form/authenticate_form.dart';

import 'helpers/api_base_helper.dart';

class AuthRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<UserDto> login({
    @required AuthenticateForm authenticate,
  }) async {

    try {
      final response = await _helper.post(
        body: authenticate.toJson(),
        url: 'authenticate',
      );

      return UserDto.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
