import 'dart:convert';

class UserForm {
  String name;
  String email;
  String password;

  UserForm({
    this.name,
    this.email,
    this.password,
  });

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name']     = this.name;
    data['email']    = this.email;
    data['password'] = this.password;

    return jsonEncode(data);
  }
}
