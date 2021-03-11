import 'package:mobx/mobx.dart';

part 'user_dto.g.dart';

class UserDto = _UserDto with _$UserDto;

abstract class _UserDto with Store {
  @observable
  int id;

  @observable
  String name;

  @observable
  String email;

  _UserDto({
    this.id,
    this.name,
    this.email,
  });

  _UserDto.fromJson(Map<String, dynamic> json) {
    id    = json.containsKey('id')    && json['id']    != null ? json['id']    : null;
    name  = json.containsKey('name')  && json['name']  != null ? json['name']  : null;
    email = json.containsKey('email') && json['email'] != null ? json['email'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']    = this.id;
    data['name']  = this.name;
    data['email'] = this.email;

    return data;
  }
}
