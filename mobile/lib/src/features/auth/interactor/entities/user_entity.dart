class UserEntity {
  String? id;
  String? name;
  String? email;
  String? token;

  UserEntity({this.id, this.name, this.email, this.token});

  UserEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}
