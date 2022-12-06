import 'dart:async';
import 'package:flutter/material.dart';

import '../Screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            headingDrawer(context),
            SizedBox(height: 20),
            drawerItem("Meals", Icons.restaurant, context),
            drawerItem("Settings", Icons.settings, context),
          ],
        ),
      ),
    );
  }

  Container headingDrawer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13.5 * 2.3,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Text(
        "Cooking Up!",
        style: TextStyle(
          fontSize: 33,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).primaryColor,
          fontFamily: 'robotocondensed',
        ),
      ),
    );
  }

  Widget drawerItem(String title, IconData icon, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: Icon(
        icon,
        size: 26,
      ),
      onTap: () => tapHandler(title, context),
    );
  }

  void tapHandler(String title, BuildContext context) {
    switch (title) {
      case 'Meals':
        {
          Navigator.of(context).pop();
          Timer(Duration(milliseconds: 200), () {
            Navigator.of(context).pushReplacementNamed('/');
          });
        }
        break;

      case 'Settings':
        {
          Navigator.of(context).pop();
          Timer(Duration(milliseconds: 200), () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          });
        }
    }
  }
}
