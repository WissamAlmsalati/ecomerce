import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import '../../../controlers/category_controler/cubit/category_cubit.dart';
import '../../category_screen/category_screen.dart';


class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final constans = Constans(context);

    return BlocProvider(
      create: (BuildContext context) {
        return CategoryCubit()..fetchCategory();
      },
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (BuildContext context, state) {
          if (state is CategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CategoryLoaded) {
            return SizedBox(
              height: constans.height * 0.08,
              width: constans.width * 0.96,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  if (kDebugMode) {
                    print('Image URL: ${state.categories[index].image}');
                  } // Print the image URL
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        CategoryScreen(
                          categoryName: state.categories[index].name,
                          categoryId: state.categories[index].id,
                        ),
                      );
                    },
                    child: Container(
                      margin: index != state.categories.length
                          ? EdgeInsets.only(
                              left: constans.mediumWidth,
                              right: constans.mediumWidth)
                          : EdgeInsets.zero,
                      width: constans.width * 0.16,
                      decoration: BoxDecoration(
                        color: constans.lightBrown,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              height: constans.height * 0.05,
                              width: constans.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Image.memory(
                                base64Decode(state.categories[index].image
                                    .split(',')
                                    .last),
                                scale: 0.5,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
