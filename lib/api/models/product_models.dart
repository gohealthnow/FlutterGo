class ProductModels {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stock;
  String? image;
  double? weight;
  double? dimensions;
  double? rating;
  String? createdAt;
  String? updatedAt;

  ProductModels(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stock,
      this.image,
      this.weight,
      this.dimensions,
      this.rating,
      this.createdAt,
      this.updatedAt});

  ProductModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    image = json['image'];
    weight = json['weight'];
    dimensions = json['dimensions'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stock'] = stock;
    data['image'] = image;
    data['weight'] = weight;
    data['dimensions'] = dimensions;
    data['rating'] = rating;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
