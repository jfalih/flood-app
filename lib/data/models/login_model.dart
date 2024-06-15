class LoginModel {
  bool? status;
  String? token;
  Data? data;

  LoginModel({this.status, this.token, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? email;
  String? name;
  String? role;
  int? trombosit;
  int? hemogoblin;

  Data({this.email, this.name, this.role, this.trombosit, this.hemogoblin});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    role = json['role'];
    trombosit = json['trombosit'];
    hemogoblin = json['hemogoblin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['role'] = role;
    data['trombosit'] = trombosit;
    data['hemogoblin'] = hemogoblin;
    return data;
  }
}