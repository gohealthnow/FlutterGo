import 'package:gohealth/api/models/product_models.dart';

class UserModels {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? email;
  String? password;
  String? name;
  String? avatar;
  String? bio;
  Role? role;
  List<ProductModels>? products;
  List<Review>? reviews;
  List<Order>? orders;

  UserModels({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.password,
    this.name,
    this.avatar,
    this.bio,
    this.role,
    this.products,
    this.reviews,
    this.orders,
  });

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      email: json['email'],
      password: json['password'],
      name: json['name'],
      avatar: json['avatar'],
      bio: json['bio'],
      role:
          Role.values.firstWhere((e) => e.toString() == 'Role.' + json['role']),
      products: json['Product'] != null
          ? (json['Product'] as List)
              .map((i) => ProductModels.fromJson(i))
              .toList()
          : null,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((i) => Review.fromJson(i)).toList()
          : null,
      orders: json['orders'] != null
          ? (json['orders'] as List).map((i) => Order.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'email': email,
      'password': password,
      'name': name,
      'avatar': avatar,
      'bio': bio,
      'role': role.toString().split('.').last,
      'products': products?.map((i) => i.toJson()).toList(),
      'reviews': reviews?.map((i) => i.toJson()).toList(),
      'orders': orders?.map((i) => i.toJson()).toList(),
    };
  }
}

enum Role { USER, ADMIN }
