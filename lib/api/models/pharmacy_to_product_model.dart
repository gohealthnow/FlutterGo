class PharmacyStockItem {
  int? id;
  int? pharmacyId;
  int? productId;
  int? quantity;

  PharmacyStockItem({this.id, this.pharmacyId, this.productId, this.quantity});

  PharmacyStockItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyId = json['pharmacyId'];
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pharmacyId'] = this.pharmacyId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }

}
