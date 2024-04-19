import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/constance.dart';

// ignore: must_be_immutable
class ViewClothes extends StatelessWidget {
  String image;
  String name;
  String price;

   ViewClothes({super.key , required this.image, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    final Constans constans = Constans(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: image,
            child: Container(
              height: constans.height * 0.19,
              width: constans.width * 0.47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(name),
          Text("\$$price"),
        ],
      ),
    );
  }
}
