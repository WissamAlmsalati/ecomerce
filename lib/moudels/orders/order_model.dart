class OrderModel {
  String id;
  String userId;
  String userName;
  String orderDate;
  String orderStatus;
  String totalPrice;
  String orderAddress;

  OrderModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.orderDate,
    required this.orderStatus,
    required this.totalPrice,
    required this.orderAddress,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      orderDate: json['orderDate'],
      orderStatus: json['orderStatus'],
      totalPrice: json['totalPrice'],
      orderAddress: json['orderAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'totalPrice': totalPrice,
      'orderAddress': orderAddress,
    };
  }
}
