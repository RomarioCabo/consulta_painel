import 'dart:convert';

class StateForm {
  String name;
  String acronym;

  StateForm({
    this.name,
    this.acronym,
  });

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']    = this.name;
    data['acronym'] = this.acronym;

    return jsonEncode(data);
  }
}
