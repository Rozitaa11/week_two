class OrderModel {
  final int id;
  final int userId;
  final String date;
  final List<OrderProduct> products;

  OrderModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'] ?? "",
      products: (json['products'] as List)
          .map((e) => OrderProduct.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "date": date,
      "products": products.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderProduct {
  final int productId;
  final int quantity;

  OrderProduct({required this.productId, required this.quantity});

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"productId": productId, "quantity": quantity};
  }
}
