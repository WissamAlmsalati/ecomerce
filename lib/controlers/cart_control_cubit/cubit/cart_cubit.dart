import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:recipes/moudels/cart/cart_model.dart';
import 'package:recipes/moudels/cart/cart_repostry.dart';
import 'package:recipes/moudels/user/user_module.dart';
import 'package:recipes/moudels/user/user_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super(CartInitial());

  List<CartModel> get cart => _cartRepository.cart;

  FirebaseFirestore get firestore => _cartRepository.firestore;

  void addToCart(CartModel item) {
    _cartRepository.addToCart(item);
    print('Item added to cart: ${item.name}');
    print('Current cart: ${_cartRepository.cart}');
    emit(CartLoaded(_cartRepository.cart, item.quantityCart));
  }

  void removeFromCart(CartModel item) {
    _cartRepository.removeFromCart(item);
    print('Item removed from cart: ${item.name}');
    print('Current cart: ${_cartRepository.cart}');
    emit(CartLoaded(List.from(_cartRepository.cart), ''));
  }

  void clearCart() {
    _cartRepository.clearCart();
    print('Cart cleared');
    emit(CartLoaded(_cartRepository.cart, ''));
  }

  Future<void> sendCartToFirebase() async {
    // Fetch the current user
    AppUser? appUser = await UserRepository.getCurrentUser();
    print('appUser: $appUser');
    if (appUser != null) {
      // Get the cart from the state
      print('Sending cart to Firebase: ${cart.map((item) => item.toMap())}');

      List<Map<String, dynamic>> cartData = cart.map((e) => e.toMap()).toList();

      Map<String, dynamic> orderData = {
        'cart': cartData,
        'createdAt': FieldValue.serverTimestamp(),
        'totalPrice': _cartRepository.totalPrice,
        'userId': appUser.id,
        'userEmail': appUser.email,
        'userName': appUser.name,
        'phoneNumber': appUser.phone,
      };

      try {
        await firestore.collection('orders').add(orderData);
        print('Order added to Firestore');
        clearCart(); // Clear the cart after the order has been added to Firestore
      } catch (e) {
        print('Error adding order to Firestore: $e');
      }
    }
  }

  void increaseQuantity(CartModel item) {
    _cartRepository.increaseQuantity(item);
    emit(CartLoaded(_cartRepository.cart, item.quantityCart));
  }

  void decreaseQuantity(CartModel item) {
    _cartRepository.decreaseQuantity(item);
    emit(CartLoaded(_cartRepository.cart, item.quantityCart));
  }
}
