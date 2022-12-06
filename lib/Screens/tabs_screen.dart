import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal_builder.dart';
import '../Widget/main_drawer.dart';
import '../Screens/categories_screen.dart';
import '../Screens/favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<MealBuilder> favouriteMeals;
  TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        "page": CategoriesScreen(),
        "title": "Category of Meals",
      },
      {
        "page": FavouritesScreen(widget.favouriteMeals),
        "title": "Your Favourites",
      }
    ];
  }

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("1 cm in pixel: " +
        (MediaQuery.of(context).size.height / 13.5).toStringAsFixed(2));
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type:
            BottomNavigationBarType.fixed, //.shifting gives us a nice animation
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text("Category"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text("Favourites"),
          ),
        ],
        onTap: _selectedPage,
      ),
    );
  }
}
