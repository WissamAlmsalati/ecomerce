import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constance.dart';
import 'recipe_widget.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({super.key});

  @override
  Widget build(BuildContext context) {
    final constans = Constans(context);

    return Center(
      child: Column(
        children: [
          Container(
            width: constans.width * 0.96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Flash Sale",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),


                ProductCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


