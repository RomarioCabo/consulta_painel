import 'package:mobx/mobx.dart';
import 'package:painel_cunsulta/shared/models/dto/profile_dto.dart';

part 'user_dto.g.dart';

class UserDto = _UserDto with _$UserDto;

abstract class _UserDto with Store {
  @observable
  int id;

  @observable
  String name;

  @observable
  String email;

  @observable
  String token;

  @observable
  ProfileDto profile;

  _UserDto({
    this.id,
    this.name,
    this.email,
    this.token,
    this.profile,
  });

  _UserDto.fromJson(Map<String, dynamic> json) {
    id      = json.containsKey('id')      && json['id']      != null ? json['id']                           : null;
    name    = json.containsKey('name')    && json['name']    != null ? json['name']                         : null;
    email   = json.containsKey('email')   && json['email']   != null ? json['email']                        : null;
    token   = json.containsKey('token')   && json['token']   != null ? json['token']                        : null;
    profile = json.containsKey('profile') && json['profile'] != null ? ProfileDto.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']      = this.id;
    data['name']    = this.name;
    data['email']   = this.email;
    data['token']   = this.token;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }

    return data;
  }
}
