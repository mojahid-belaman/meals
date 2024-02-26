import 'package:flutter/material.dart';
import 'package:meals/dummy_data/categories.dart';

import 'package:meals/modals/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/drawer_main.dart';

const kInitailFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreen();
  }
}

class _TabScreen extends State<TabScreen> {
  var indexScreen = 0;
  final List<Meal> favoriteMeals = [];
  Map<Filter, bool> selectedFilter = kInitailFilter;

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
  }

  void _toggleFavoriteMeal(Meal meal) {
    final existMeal = favoriteMeals.contains(meal);
    if (existMeal) {
      setState(() {
        favoriteMeals.remove(meal);
      });
      _showMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        favoriteMeals.add(meal);
      });
      _showMessage('Marked as a favorite!');
    }
  }

  void selectCurrentScrren(int index) {
    setState(() {
      indexScreen = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
            builder: (ctx) => FiltersScreen(
                  onSelectScreen: _setScreen,
                  initialFilter: selectedFilter,
                )),
      );
      setState(() {
        selectedFilter = result!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = meals.where((meal) {
      if (selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget currentScreen = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteMeal,
      selectedMeals: availableMeals,
    );
    var titleScreen = 'Categories';
    if (indexScreen == 1) {
      currentScreen = MealScreen(
        meals: favoriteMeals,
        onToggleFavorite: _toggleFavoriteMeal,
      );
      titleScreen = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleScreen,
        ),
      ),
      drawer: DrawerMain(
        selectScreen: _setScreen,
      ),
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexScreen,
        onTap: selectCurrentScrren,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites')
        ],
      ),
    );
  }
}
