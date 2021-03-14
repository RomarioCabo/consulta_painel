import 'package:mobx/mobx.dart';

part 'state_dto.g.dart';

class StateDto = _StateDto with _$StateDto;

abstract class _StateDto with Store {
  @observable
  int id;

  @observable
  String name;

  @observable
  String acronym;

  @observable
  String urlImage;

  _StateDto({
    this.id,
    this.name,
    this.acronym,
    this.urlImage,
  });

  _StateDto.fromJson(Map<String, dynamic> json) {
    id       = json.containsKey('id')       && json['id']       != null ? json['id']       : null;
    name     = json.containsKey('name')     && json['name']     != null ? json['name']     : null;
    acronym  = json.containsKey('acronym')  && json['acronym']  != null ? json['acronym']  : null;
    urlImage = json.containsKey('urlImage') && json['urlImage'] != null ? json['urlImage'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']       = this.id;
    data['name']     = this.name;
    data['acronym']  = this.acronym;
    data['urlImage'] = this.urlImage;

    return data;
  }
}
