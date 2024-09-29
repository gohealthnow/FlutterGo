import 'package:gohealth/api/models/pharmacy_to_product_model.dart';
import 'package:gohealth/api/models/user_models.dart';

class ProductModels {
  int? id;
  String? name;
  String? description;
  double? price;
  String? image;
  double? weight;
  double? dimensions;
  double? rating;
  String? createdAt;
  String? updatedAt;
  List<UserModels>? user;
  List<PharmacyStockItem>? pharmacyProduct;
  List<Null>? reviews;
  List<Null>? categories;

  ProductModels(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.image,
      this.weight,
      this.dimensions,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.pharmacyProduct,
      this.reviews,
      this.categories});

  ProductModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    weight = json['weight'];
    dimensions = json['dimensions'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['user'] != null) {
      user = <UserModels>[];
      json['user'].forEach((v) {
        user!.add(new UserModels.fromJson(v));
      });
    }
    if (json['PharmacyProduct'] != null) {
      pharmacyProduct = <PharmacyStockItem>[];
      json['PharmacyProduct'].forEach((v) {
        pharmacyProduct!.add(new PharmacyStockItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['weight'] = this.weight;
    data['dimensions'] = this.dimensions;
    data['rating'] = this.rating;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    if (this.pharmacyProduct != null) {
      data['PharmacyProduct'] =
          this.pharmacyProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
