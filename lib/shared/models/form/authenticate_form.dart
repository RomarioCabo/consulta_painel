import 'dart:convert';

class AuthenticateForm {
  String email;
  String password;

  AuthenticateForm({
    this.email,
    this.password,
  });

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email']    = this.email;
    data['password'] = this.password;

    return jsonEncode(data);
  }
}