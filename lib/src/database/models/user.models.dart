class User {
  int? _id;
  String? _createdAt;
  String? _updatedAt;
  String? _email;
  String? _password;
  String? _name;
  Null? _avatar;
  Null? _bio;
  String? _role;

  User(
      {int? id,
      String? createdAt,
      String? updatedAt,
      String? email,
      String? password,
      String? name,
      Null? avatar,
      Null? bio,
      String? role}) {
    if (id != null) {
      _id = id;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (email != null) {
      _email = email;
    }
    if (password != null) {
      _password = password;
    }
    if (name != null) {
      _name = name;
    }
    if (role != null) {
      _role = role;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get name => _name;
  set name(String? name) => _name = name;
  Null? get avatar => _avatar;
  set avatar(Null? avatar) => _avatar = avatar;
  Null? get bio => _bio;
  set bio(Null? bio) => _bio = bio;
  String? get role => _role;
  set role(String? role) => _role = role;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _email = json['email'];
    _password = json['password'];
    _name = json['name'];
    _avatar = json['avatar'];
    _bio = json['bio'];
    _role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['email'] = _email;
    data['password'] = _password;
    data['name'] = _name;
    data['avatar'] = _avatar;
    data['bio'] = _bio;
    data['role'] = _role;
    return data;
  }
}
