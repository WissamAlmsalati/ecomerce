import 'dart:core';

class CartModel {
  final String id;
  final String name;
  final String image;
  final String price;
  final String quantityCart;
  final String size;

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantityCart,
    required this.size,
  });

  factory CartModel.fromMap(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      quantityCart: json['quantityCart'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantityCart': quantityCart,
      'size': size,
    };
  }
}
