import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constance.dart';
import 'recipe_widget.dart';

class LatestRecipes extends StatelessWidget {
  const LatestRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: Constans.width(context) * 0.96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Latest Recipes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                RecipeWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
