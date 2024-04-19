import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/views/home_screen/components/text_row.dart';
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
                TextRow(
                  text: 'Flash Sale',
                  tapText: 'View All',
                  onTap: () {},
                ),
                const ClothesCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


