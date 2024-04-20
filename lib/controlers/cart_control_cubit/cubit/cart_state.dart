part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartModel> cart;
  final String quantity;

  CartLoaded(this.cart, this.quantity);

  @override
  List<Object> get props => [cart, quantity];

  double get totalPrice => cart.fold(
      0,
      (sum, item) =>
          sum + (double.parse(item.price) * int.parse(item.quantityCart)));
}

class CartSentToFirebase extends CartState {}
