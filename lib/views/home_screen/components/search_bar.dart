import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constance.dart';
import '../../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';

class CoustomeSearchBar extends StatelessWidget {
  const CoustomeSearchBar({Key? key});

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
                          pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(0.0, 1.0);
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

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final Constans constants = Constans(context);

    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) {
          return FetchRecipesCubit();
        },
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: constants.smallWidth),
                child: Hero(
                  tag: 'searchBar',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            searchTerm = value;
                          });
                        },
                        autofocus: true,
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
                        onChanged: (value) {
                          setState(() {
                            searchTerm = value;
                          });

                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<FetchRecipesCubit, FetchRecipesState>(
                  builder: (context, state) {
                    if (state is DataLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is DataLoaded) {
                      if (state.recipes.isEmpty) {
                        return Center(child: Text('No recipes found'));
                      } else {
                        return ListView.builder(
                          itemCount: state.recipes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.recipes[index].name),
                              // Add more details about each recipe here
                            );
                          },
                        );
                      }
                    } else if (state is DataError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return Container(
                        child: Text('Unknown state'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}