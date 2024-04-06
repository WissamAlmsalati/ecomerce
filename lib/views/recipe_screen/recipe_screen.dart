import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/constance.dart';

import '../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';

class RecipeScreen extends StatelessWidget {
  String recipeId;
  String recipeName;
  String recipeDescription;
  String recipeImage;
  String recipeIngredients;
  String recipeSteps;

  RecipeScreen(
      {super.key,
      required this.recipeId,
      required this.recipeName,
      required this.recipeDescription,
      required this.recipeImage,
      required this.recipeIngredients,
      required this.recipeSteps});

  @override
  Widget build(BuildContext context) {

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
            Container(
                height: Constans.height(context) * 0.3,
                width: Constans.width(context) * 0.96,
                child: Image.memory(
                  base64Decode(recipeImage.split(',').last),
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                )),
            Text(recipeDescription),
            Text(recipeIngredients),
            Text(recipeSteps),

            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Add To Cart")),
                  Text("Price")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
