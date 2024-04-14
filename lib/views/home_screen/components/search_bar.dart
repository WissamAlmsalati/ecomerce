import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constance.dart';
import '../../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';
import '../../search_screen/search_screen.dart';

class CoustomeSearchBar extends StatelessWidget {
  const CoustomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Constans constants = Constans(context);

    return Padding(
      padding: EdgeInsets.only(
        left: constants.smallWidth,
        right: constants.smallWidth,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: constants.mediumWidth),
              child: Hero(
                tag: 'searchBar',
                child: Material(
                  type: MaterialType.transparency,
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>  SearchScreen( showBackArrow: true),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Iconsax.search_normal,
                        color: constants.brown,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: constants.brown,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Iconsax.filter, size: 30, color: constants.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

