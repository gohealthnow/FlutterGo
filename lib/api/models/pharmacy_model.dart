import 'package:gohealth/api/models/product_models.dart';

class PharmacyModels {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? description;
  String? phone;
  String? email;
  String? image;
  Geolocation? geolocation;
  List<PharmacyProduct>? pharmacyProducts;

  PharmacyModels({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.description,
    this.phone,
    this.email,
    this.image,
    this.geolocation,
    this.pharmacyProducts,
  });

  PharmacyModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    geolocation = json['geolocation'] != null
        ? Geolocation.fromJson(json['geolocation'])
        : null;
    if (json['PharmacyProduct'] != null) {
      pharmacyProducts = <PharmacyProduct>[];
      json['PharmacyProduct'].forEach((v) {
        pharmacyProducts!.add(PharmacyProduct.fromJson(v));
      });
    }
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
    if (geolocation != null) {
      data['geolocation'] = geolocation!.toJson();
    }
    if (pharmacyProducts != null) {
      data['PharmacyProduct'] =
          pharmacyProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'PharmacyModels{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, description: $description, phone: $phone, email: $email, image: $image, geolocation: $geolocation, pharmacyProducts: $pharmacyProducts}';
  }
}

class Geolocation {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? latitude;
  int? longitude;
  String? address;
  String? additional;
  String? cep;
  String? city;

  Geolocation({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
    this.address,
    this.additional,
    this.cep,
    this.city,
  });

  Geolocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    additional = json['additional'];
    cep = json['cep'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['additional'] = additional;
    data['cep'] = cep;
    data['city'] = city;
    return data;
  }

  @override
  String toString() {
    return 'Geolocation{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, latitude: $latitude, longitude: $longitude, address: $address, additional: $additional, cep: $cep, city: $city}';
  }
}

class PharmacyProduct {
  int? pharmacyId;
  int? productId;
  int? quantity;

  PharmacyProduct({this.pharmacyId, this.productId, this.quantity});

  PharmacyProduct.fromJson(Map<String, dynamic> json) {
    pharmacyId = json['pharmacyId'];
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pharmacyId'] = pharmacyId;
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }

  @override
  String toString() {
    return 'PharmacyProduct{pharmacyId: $pharmacyId, productId: $productId, quantity: $quantity}';
  }
}
