import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../constance.dart';
import '../../controlers/recipes_controler/cubti_recipes/fetch_recipes_cubit.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
   bool showBackArrow = false;

  SearchScreen({super.key, this.showBackArrow = false});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final Constans constants = Constans(context);

    return BlocProvider(
      create: (BuildContext context) {
        return FetchRecipesCubit()..fetchRecipes();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
            leading: widget.showBackArrow ? const BackButton() : null,
        ),
        body: SafeArea(
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
                        autofocus: widget.showBackArrow ? true : false,
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
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DataLoaded) {
                      if (state.clothes.isEmpty) {
                        return const Center(child: Text('No recipes found'));
                      } else {
                        return ListView.builder(
                          itemCount: state.clothes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.clothes[index].name),
                              // Add more details about each recipe here
                            );
                          },
                        );
                      }
                    } else if (state is DataError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return const Text('Unknown state');
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