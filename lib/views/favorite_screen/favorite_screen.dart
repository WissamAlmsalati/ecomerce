import 'package:flutter/material.dart';

import '../home_screen/components/recipe_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body:const ClothesCard(),
    );
  }
}
