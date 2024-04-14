import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipes/constance.dart';

import 'componets/text_description.dart';

class ClothesScreen extends StatefulWidget {
  String recipeId;
  String recipeName;
  String recipeDescription;
  String recipeImage;
  String discount;

  ClothesScreen(
      {super.key,
      required this.recipeId,
      required this.recipeName,
      required this.recipeDescription,
      required this.recipeImage,
      required this.discount});

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  bool _isExpanded = false;
  String selectedSize = '';

  @override
  Widget build(BuildContext context) {
    List<String> sizes = ['S', 'M', 'L', 'XL'];

    final constans = Constans(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.recipeName),
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
              child: Image.network(widget.recipeImage, fit: BoxFit.cover),
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
        height: 80,
        width: constans.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              const Text("Price"),
              const Spacer(),



              SizedBox(
                width: 180,
                height: 60,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(constans.brown),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {}, child: const Row(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.white,),
                        Spacer(),
                        Text("Add To Cart", style: TextStyle(color: Colors.white),),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
