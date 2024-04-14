import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/constance.dart';

import '../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';

class ClothesScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {

    final constans = Constans(context);

    List<String> tabs=[
      "المكونات",
      "الوصفات"
    ];


    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
                height: constans.height * 0.3,
                width: constans.width * 0.96,
                child: Image.network(recipeImage)),
            
            Text(recipeDescription),


            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Add To Cart")),
                  const Text("Price")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
