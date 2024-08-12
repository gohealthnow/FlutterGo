class UserModels {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? name;
  String? avatar;
  Map? product;
  String? bio;
  String? role;

  UserModels({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.name,
    this.role,
    this.avatar,
    this.product,
    this.bio,
  });

  UserModels.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        email = json['email'],
        name = json['name'],
        avatar = json['avatar'],
        product = json['product'],
        bio = json['bio'],
        role = json['role'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['email'] = email;
    data['name'] = name;
    data['avatar'] = avatar;
    data['product'] = product;
    data['bio'] = bio;
    data['role'] = role;
    return data;
  }
}
