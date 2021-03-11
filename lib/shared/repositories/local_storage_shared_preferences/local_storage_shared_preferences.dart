import 'dart:convert';

import 'package:painel_cunsulta/constants/tags.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSharedPreferences {
  SharedPreferences prefs;
  Future _doneFuture;

  Future get initializationDone => _doneFuture;

  LocalStorageSharedPreferences() {
    _doneFuture = _initDB();
  }

  _initDB() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveUser(UserDto user) {
    if (user == null) {
      prefs.remove(tagUser);
    } else {
      prefs.setString(tagUser, jsonEncode(user.toJson()));
    }
  }

  UserDto getUser() {
    String user = prefs.get(tagUser);
    return user != null && user.isNotEmpty
        ? UserDto.fromJson(jsonDecode(user))
        : null;
  }
}
