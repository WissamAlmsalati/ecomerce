import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../constance.dart';
import 'components/banner.dart';
import 'components/category_widget.dart';
import 'components/last_recipes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const BannerWidget(),
              SizedBox(
                height: Constans.height(context) * 0.02,
              ),
              const CategoryWidget(),
              SizedBox(
                height: Constans.height(context) * 0.02,
              ),
              const LatestRecipes(),
            ],
          ),
        ),
      ),

    );
  }
}

