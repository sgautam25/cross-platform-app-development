import 'package:flutter/material.dart';

import '../Models/dummy_data.dart';
import '../Models/meal_builder.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/category-meals/meal-details';

  final Function _isFavourite;
  final Function _toggleFavourite;

  MealDetailsScreen(this._isFavourite, this._toggleFavourite);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final meal = DUMMY_MEALS.firstWhere((mealItem) => (mealItem.id == id));
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: <Widget>[
          IconButton(
            icon:
                Icon(_isFavourite(id) ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              return _toggleFavourite(id);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildHeading(context, "Ingredients"),
            ingredientsList(meal),
            buildHeading(context, "Recipes"),
            recipeList(meal),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(id),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  } //build

  Widget buildHeading(BuildContext context, String heading) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        heading,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      width: 300,
      child: child,
    );
  }

  Widget ingredientsList(MealBuilder meal) {
    return buildContainer(
      ListView.builder(
        itemCount: meal.ingredients.length,
        itemBuilder: (context, index) {
          return Card(
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(meal.ingredients[index]),
            ),
          );
        },
      ),
    );
  }

  Widget recipeList(MealBuilder meal) {
    return buildContainer(
      ListView.builder(
        itemCount: meal.steps.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Text('# ${index + 1}'),
                ),
                title: Text(meal.steps[index]),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
