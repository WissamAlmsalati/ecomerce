class OrderModel {
  String? id;
  String? userId;
  String? userName;
  List<String>? orderItems;
  String? orderDate;
  String? orderStatus;
  String? totalPrice;
  String? orderAddress;

  OrderModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.orderDate,
    required this.orderStatus,
    required this.totalPrice,
    required this.orderAddress,
    required this.orderItems,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      userId: map['userId'],
      userName: map['userName'],
      orderDate: map['orderDate'],
      orderStatus: map['orderStatus'],
      totalPrice: map['totalPrice'],
      orderAddress: map['orderAddress'],
      orderItems: map['orderItems'].cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'totalPrice': totalPrice,
      'orderAddress': orderAddress,
      'orderItems': orderItems,
    };
  }
}