import 'dart:convert';

class UserForm {
  String name;
  String email;
  String password;
  int codProfile;

  UserForm({
    this.name,
    this.email,
    this.password,
    this.codProfile
  });

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']       = this.name;
    data['email']      = this.email;
    data['password']   = this.password;
    data['codProfile'] = this.codProfile;

    return jsonEncode(data);
  }
}
