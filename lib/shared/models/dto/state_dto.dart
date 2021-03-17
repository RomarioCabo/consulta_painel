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

  @observable
  String capital;

  @observable
  String gentle;

  @observable
  int territorialArea;

  @observable
  int totalCounties;

  @observable
  int totalPopulation;

  @observable
  double demographicDensity;

  @observable
  double idh;

  @observable
  String borderingTerritory;

  @observable
  double pib;

  @observable
  String naturalAspects;

  @observable
  String economicActivities;

  @observable
  String curiosity;

  @observable
  String region;

  _StateDto({
    this.id,
    this.name,
    this.acronym,
    this.urlImage,
    this.capital,
    this.gentle,
    this.territorialArea,
    this.totalCounties,
    this.totalPopulation,
    this.demographicDensity,
    this.idh,
    this.borderingTerritory,
    this.pib,
    this.naturalAspects,
    this.economicActivities,
    this.curiosity,
    this.region,
  });

  _StateDto.fromJson(Map<String, dynamic> json) {
    id                 = json.containsKey('id')                 && json['id']                 != null ? json['id']                 : null;
    name               = json.containsKey('name')               && json['name']               != null ? json['name']               : null;
    acronym            = json.containsKey('acronym')            && json['acronym']            != null ? json['acronym']            : null;
    urlImage           = json.containsKey('urlImage')           && json['urlImage']           != null ? json['urlImage']           : null;
    capital            = json.containsKey('capital')            && json['capital']            != null ? json['capital']            : null;
    gentle             = json.containsKey('gentle')             && json['gentle']             != null ? json['gentle']             : null;
    territorialArea    = json.containsKey('territorialArea')    && json['territorialArea']    != null ? json['territorialArea']    : null;
    totalCounties      = json.containsKey('totalCounties')      && json['totalCounties']      != null ? json['totalCounties']      : null;
    totalPopulation    = json.containsKey('totalPopulation')    && json['totalPopulation']    != null ? json['totalPopulation']    : null;
    demographicDensity = json.containsKey('demographicDensity') && json['demographicDensity'] != null ? json['demographicDensity'] : null;
    idh                = json.containsKey('idh')                && json['idh']                != null ? json['idh']                : null;
    borderingTerritory = json.containsKey('borderingTerritory') && json['borderingTerritory'] != null ? json['borderingTerritory'] : null;
    pib                = json.containsKey('pib')                && json['pib']                != null ? json['pib']                : null;
    naturalAspects     = json.containsKey('naturalAspects')     && json['naturalAspects']     != null ? json['naturalAspects']     : null;
    economicActivities = json.containsKey('economicActivities') && json['economicActivities'] != null ? json['economicActivities'] : null;
    curiosity          = json.containsKey('curiosity')          && json['curiosity']          != null ? json['curiosity']          : null;
    region             = json.containsKey('region')             && json['region']             != null ? json['region']             : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']                 = this.id;
    data['name']               = this.name;
    data['acronym']            = this.acronym;
    data['urlImage']           = this.urlImage;
    data['capital']            = this.capital;
    data['gentle']             = this.gentle;
    data['territorialArea']    = this.territorialArea;
    data['totalCounties']      = this.totalCounties;
    data['totalPopulation']    = this.totalPopulation;
    data['demographicDensity'] = this.demographicDensity;
    data['idh']                = this.idh;
    data['borderingTerritory'] = this.borderingTerritory;
    data['pib']                = this.pib;
    data['naturalAspects']     = this.naturalAspects;
    data['economicActivities'] = this.economicActivities;
    data['curiosity']          = this.curiosity;
    data['region']             = this.region;

    return data;
  }
}
