class RestUserModel {
  RestUserModel({
    this.id,
    this.name,
    this.email,
  });

  RestUserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }
  num? id;
  String? name;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    return map;
  }
}
