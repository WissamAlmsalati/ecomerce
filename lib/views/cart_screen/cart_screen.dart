import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/constance.dart';
import 'package:recipes/controlers/cart_control_cubit/cubit/cart_cubit.dart';
import 'package:recipes/moudels/cart/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Constans constans = Constans(context);

    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      if (state is CartLoaded) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (BuildContext context, int index) {
                    CartModel item = state.cart[index];
                    return Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: constans.width * 0.03,
                            ),
                            height: constans.height * 0.1,
                            width: constans.width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(item.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: constans.width * 0.03,
                                top: constans.height * 0.02,
                                bottom: constans.height * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  item.size,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  item.price,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<CartCubit>().removeFromCart(item);
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 100,
            width: constans.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Total: ${state.totalPrice}'),
                ElevatedButton(
                  onPressed: () {
                    try {
                      context.read<CartCubit>().sendCartToFirebase();
                    } catch (e) {
                      print('Error sending cart to Firebase: $e');
                    }
                  },
                  child: Text('Checkout'),
                )
              ],
            ),
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
