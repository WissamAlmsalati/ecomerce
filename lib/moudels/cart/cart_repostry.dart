import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes/moudels/cart/cart_model.dart';

class CartRepository {
  final List<CartModel> _cart = [];
  final _firestore = FirebaseFirestore.instance;

  List<CartModel> get cart => _cart;
  FirebaseFirestore get firestore => _firestore;

  void addToCart(CartModel item) {
    _cart.add(item);
  }

  void removeFromCart(CartModel item) {
    _cart.remove(item);
  }

  double get totalPrice => _cart.fold(
      0,
      (total, current) =>
          total +
          double.parse(current.price) * int.parse(current.quantityCart));

  Future<void> sendCartToFirebase() async {
    for (var item in _cart) {
      await _firestore.collection('orders').add(item.toMap());
    }
  }

  void clearCart() {
    _cart.clear();
  }

  void increaseQuantity(CartModel item) {
    int index = _cart.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _cart[index] = CartModel(
        id: item.id,
        name: item.name,
        image: item.image,
        price: item.price,
        quantityCart: (int.parse(item.quantityCart) + 1).toString(),
        size: item.size,
      );
    }
  }

  void decreaseQuantity(CartModel item) {
    int index = _cart.indexWhere((i) => i.id == item.id);
    if (index != -1 && int.parse(_cart[index].quantityCart) > 1) {
      _cart[index] = CartModel(
        id: item.id,
        name: item.name,
        image: item.image,
        price: item.price,
        quantityCart: (int.parse(item.quantityCart) - 1).toString(),
        size: item.size,
      );
    }
  }
}
