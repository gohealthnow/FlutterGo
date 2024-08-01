class UserModels {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? password;
  String? name;
  String? avatar;
  String? bio;
  String? role;

  UserModels({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
    this.bio,
  });

  UserModels.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        email = json['email'],
        password = json['password'],
        name = json['name'],
        avatar = json['avatar'],
        bio = json['bio'],
        role = json['role'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['avatar'] = avatar;
    data['bio'] = bio;
    data['role'] = role;
    return data;
  }
}
