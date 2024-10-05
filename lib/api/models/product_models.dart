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
  List<Review>? reviews;
  List<String>? categories;

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

  factory ProductModels.fromJson(Map<String, dynamic> json) {
    return ProductModels(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      weight: json['weight'],
      dimensions: json['dimensions'],
      rating: json['rating'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      categories: json['categories'] != null
          ? (json['categories'] as List).map((i) => i.toString()).toList()
          : null,
      user: json['user'] != null
          ? (json['user'] as List).map((i) => UserModels.fromJson(i)).toList()
          : null,
      pharmacyProduct: json['PharmacyProduct'] != null
          ? (json['PharmacyProduct'] as List)
              .map((i) => PharmacyStockItem.fromJson(i))
              .toList()
          : null,
      reviews: json['review'] != null
          ? (json['review'] as List).map((i) => Review.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'weight': weight,
      'dimensions': dimensions,
      'rating': rating,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user?.map((v) => v.toJson()).toList(),
      'PharmacyProduct': pharmacyProduct?.map((v) => v.toJson()).toList(),
      'review': reviews?.map((v) => v.toJson()).toList(),
    };
  }
}

class Order {
  String id;
  int userId;
  int productId;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;
  ProductModels product;
  UserModels user;

  Order({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.user,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      product: ProductModels.fromJson(json['product']),
      user: UserModels.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'product': product.toJson(),
      'user': user.toJson(),
    };
  }
}

class Review {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String title;
  String body;
  double rating;

  Review({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.body,
    required this.rating,
  });

  Review.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']),
        title = json['title'],
        body = json['body'],
        rating = json['rating'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'title': title,
      'body': body,
      'rating': rating,
    };
  }
}
