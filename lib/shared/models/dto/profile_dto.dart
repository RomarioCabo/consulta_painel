import 'package:mobx/mobx.dart';

part 'profile_dto.g.dart';

class ProfileDto = _ProfileDto with _$ProfileDto;

abstract class _ProfileDto with Store {
  @observable
  int id;

  @observable
  int codProfile;

  @observable
  String profileType;

  _ProfileDto({
    this.id,
    this.codProfile,
    this.profileType,
  });

  _ProfileDto.fromJson(Map<String, dynamic> json) {
    id          = json.containsKey('id')          && json['id']          != null ? json['id']          : null;
    codProfile  = json.containsKey('codProfile')  && json['codProfile']  != null ? json['codProfile']  : null;
    profileType = json.containsKey('profileType') && json['profileType'] != null ? json['profileType'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']          = this.id;
    data['codProfile']  = this.codProfile;
    data['profileType'] = this.profileType;

    return data;
  }
}
