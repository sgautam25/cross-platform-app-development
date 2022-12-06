import 'package:flutter/material.dart';
import '../Widget/list_meals.dart';
import '../Models/meal_builder.dart';

class FavouritesScreen extends StatelessWidget {
  final List<MealBuilder> _favouriteMeals;

  FavouritesScreen(this._favouriteMeals);
  @override
  Widget build(BuildContext context) {
    if (_favouriteMeals.isEmpty) {
      return Center(
        child: Text("You have not selected any Favourites - Go and add some!!"),
      );
    } else {
      return ListView.builder(
        itemCount: _favouriteMeals.length,
        itemBuilder: (BuildContext context, int index) {
          var item = _favouriteMeals[index];
          return ListMeals(
            id: item.id,
            title: item.title,
            imageUrl: item.imageUrl,
            duration: item.duration,
            affordability: item.affordability,
            complexity: item.complexity,
            removeItem: null,
          );
        },
      );
    }
  }
}
