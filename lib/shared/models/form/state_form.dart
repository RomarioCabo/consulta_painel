import 'dart:convert';

class StateForm {
  String name;
  String acronym;
  String fileInBase64;

  StateForm({
    this.name,
    this.acronym,
    this.fileInBase64,
  });

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']         = this.name;
    data['acronym']      = this.acronym;
    data['fileInBase64'] = this.fileInBase64;

    return jsonEncode(data);
  }
}
