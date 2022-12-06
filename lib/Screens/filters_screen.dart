import 'package:flutter/material.dart';
import '../Widget/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Map<String, bool> filtersFromMain;
  final Function saveFilters;
  FiltersScreen(this.filtersFromMain, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.filtersFromMain['glutenFree'];
    _lactoseFree = widget.filtersFromMain['lactoseFree'];
    _vegan = widget.filtersFromMain['vegan'];
    _vegetarian = widget.filtersFromMain['vegetarian'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> selectedFilters = {
                'glutenFree': _glutenFree,
                'lactoseFree': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              Navigator.of(context).pushReplacementNamed('/');
              return widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
            alignment: Alignment.center,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildFilters(_glutenFree, "Gluten-Free",
                    "Only included Gluten-free meals", (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildFilters(_lactoseFree, "Lactose-Free",
                    "Only included Lactose-free meals", (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                buildFilters(_vegan, "Vegan", "Only included Vegan meals",
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                buildFilters(
                    _vegetarian, "Vegetarian", "Only included Vegetarian meals",
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _glutenFree = false;
            _lactoseFree = false;
            _vegan = false;
            _vegetarian = false;
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  SwitchListTile buildFilters(
      bool filter, String title, String subtitle, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: filter,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }
}
