import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constance.dart';
import '../../../controlers/category_controler/cubit/category_cubit.dart';
import '../../../moudels/category/category_module.dart';
import '../../category_screen/category_screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            return Container(
              height: Constans.height(context) * 0.1,
              width: Constans.width(context) * 0.96,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  print('Image URL: ${state.categories[index].image}'); // Print the image URL
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          categoryName: state.categories[index].name,
                          categoryId: state.categories[index].id,
                      ))
                      );
                    },
                    child: Container(
                      height: Constans.height(context) * 0.1,
                      width: Constans.width(context) * 0.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Container(
                        margin: index == 0
                            ? const EdgeInsets.only(left: 0)
                            : const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: Constans.height(context) * 0.06,
                              width: Constans.width(context) * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child:Image.memory(
                                base64Decode(state.categories[index].image.split(',').last),
                                scale: 0.5,

                              )
                            ),
                            Text(state.categories[index].name,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1
                            ),
                          ],
                        ),
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