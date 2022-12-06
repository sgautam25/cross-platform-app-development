import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal_builder.dart';

import './Models/dummy_data.dart';
import './Screens/filters_screen.dart';
import './Screens/category_meals_screen.dart';
import './Screens/meal_details_screen.dart';
import './Screens/tabs_screen.dart';
import './Screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<MealBuilder> _availableMeals = DUMMY_MEALS;
  List<MealBuilder> _favouriteMeals = [];

  void _toggleFavourite(String mealId) {
    final indexMeal = _favouriteMeals.indexWhere((meal) => (meal.id == mealId));
    if (indexMeal >= 0) {
      setState(() {
        _favouriteMeals.removeAt(indexMeal);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => (meal.id == mealId)));
      });
    }
  }

  bool _isFavourite(String id) {
    return _favouriteMeals.any((element) => element.id == id);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['glutenFree'] && !meal.isGlutenFree) return false;
        if (_filters['lactoseFree'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _favouriteMeals.forEach((meal) {
      print("Favourite meals : " + meal.title);
    });
    _availableMeals.forEach((meal) {
      print("available meals " + meal.title);
    });
    return MaterialApp(
      title: "Deli Meals",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        '/': (_) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.routeName: (_) =>
            MealDetailsScreen(_isFavourite, _toggleFavourite),
        FiltersScreen.routeName: (_) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(
            "You have accessed onGenerate route. This is only used for pages that are not tracked by home and routes. It is mostly used for some known bugs in your application.");
        return MaterialPageRoute(
          builder: (_) {
            return CategoriesScreen();
          },
        );
      },
      onUnknownRoute: (settings) {
        print("You have reached an unknown Page");
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              appBar: AppBar(title: Text("404 error")),
              body: Center(child: Text("You have reached an unknown page")),
            );
          },
        );
      },
    );
  }
}
