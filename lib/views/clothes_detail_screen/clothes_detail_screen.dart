import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipes/constance.dart';
import 'package:recipes/controlers/cart_control_cubit/cubit/cart_cubit.dart';
import 'package:recipes/moudels/cart/cart_model.dart';
import 'package:recipes/moudels/orders/order_repostry.dart';
import '../../moudels/orders/order_model.dart';


// ignore: must_be_immutable
class ClothesScreen extends StatefulWidget {
  String recipeId;
  String recipeName;
  String recipeDescription;
  String recipeImage;
  String discount;
  String price;
  String size;
  String quantity;

  ClothesScreen(
      {super.key,
      required this.recipeId,
      required this.recipeName,
      required this.recipeDescription,
      required this.recipeImage,
      required this.price,
      required this.discount,
        required this.size,
        required this.quantity


      });

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  bool _isExpanded = false;
  String selectedSize = '';



String checkPriceAndQuantity() {
  double quantity = double.parse(widget.quantity);
  double price = double.parse(widget.price);

  if(quantity == 0){
    return 'Out of Stock';
  }else{
    return '\$${price.toStringAsFixed(2)}';
  }
}

  @override
  Widget build(BuildContext context) {
  Constans constans = Constans(context);
    List<String> sizes = ['S', 'M', 'L', 'XL'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: constans.height * 0.05,
            ),
            SizedBox(
              height: constans.height * 0.44,
              width: constans.width,
              child: Hero(
                  tag: widget.recipeImage,
                  child: Image.network(widget.recipeImage,
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.recipeName,
                          style: TextStyle(fontSize: 15, color: constans.grey)),
                      const Spacer(),
                      const Icon(Iconsax.star, color: Colors.yellow),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("Product Details",
                      style: TextStyle(fontSize: 20, color: constans.black)),
                  const SizedBox(height: 10),
                  Text(
                    widget.recipeDescription,
                    maxLines: _isExpanded ? null : 2,
                    overflow: TextOverflow.fade,
                  ),
                  GestureDetector(
                    child: Text(_isExpanded ? 'Show Less' : 'Show More'),
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                  ),
                  Divider(color: Colors.black.withOpacity(0.5)),
                  const SizedBox(height: 10),
                  Text("Size",
                      style: TextStyle(fontSize: 20, color: constans.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: sizes.map((size) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return ChoiceChip(
                            backgroundColor: constans.white,
                            selectedColor: constans.brown,
                            label: Text(size),
                            selected: selectedSize == size,
                            onSelected: (selected) {
                              setState(() {
                                if (selectedSize == size) {
                                  selectedSize =
                                      ''; // Unselect the size if it's already selected
                                } else {
                                  selectedSize =
                                      size; // Select the size if it's not selected
                                }
                              });
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
     bottomNavigationBar: Container(
  height: 100,
  width: constans.width,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black.withOpacity(0.2)),
    color: Colors.white,
    borderRadius:  const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  ),
  child: Padding(
    padding:  const EdgeInsets.only(left: 15, right: 15),
    child: Row(
      children: [
        Row(
          children: [
            Text(
              widget.price,
              style: TextStyle(fontSize: constans.height * 0.02, color: constans.brown),
            ),
          ],
        ),
        const Spacer(),
        double.parse(widget.quantity) == 0
          ? Text(
              'Out of Stock',
              style: TextStyle(fontSize: constans.height * 0.014, color: Colors.red),
            )
          : SizedBox(
              width: constans.width * 0.4,
              height: constans.height * 0.06,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(constans.brown),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
            context.read<CartCubit>().addToCart(
              CartModel(
                id: widget.recipeId,
                name: widget.recipeName,
                price: widget.price,
                size: selectedSize,
                quantityCart: '1',
                image: widget.recipeImage,
              ),
            );
          },
                  child:  Row(
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.white ,fontSize:constans.height * 0.01),
                      ),
                    ],
                  )),
            ),
      ],
    ),
  ),
),
    );
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }




}
