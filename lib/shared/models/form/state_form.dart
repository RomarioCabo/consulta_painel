import 'dart:convert';

class StateForm {
  String name;
  String acronym;
  String fileInBase64;
  String capital;
  String gentle;
  int territorialArea;
  int totalCounties;
  int totalPopulation;
  double demographicDensity;
  double idh;
  String borderingTerritory;
  double pib;
  String naturalAspects;
  String economicActivities;
  String curiosity;
  String region;

  StateForm({
    this.name,
    this.acronym,
    this.fileInBase64,
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

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']               = this.name;
    data['acronym']            = this.acronym;
    data['fileInBase64']       = this.fileInBase64;
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

    return jsonEncode(data);
  }
}
