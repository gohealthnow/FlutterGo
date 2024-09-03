class PharmacyModels {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? description;
  String? phone;
  String? email;
  String? image;

  PharmacyModels(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.description,
      this.phone,
      this.email,
      this.image});

  PharmacyModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['name'] = name;
    data['description'] = description;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    return data;
  }

  @override
  String toString() {
    return 'PharmacyModels{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, description: $description, phone: $phone, email: $email, image: $image}';
  }
}
