import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/providers/favorite_provider.dart';
import 'package:meals/providers/filter_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/drawer_main.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreen();
  }
}

class _TabScreen extends ConsumerState<TabScreen> {
  var indexScreen = 0;

  void selectCurrentScrren(int index) {
    setState(() {
      indexScreen = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);
    Widget currentScreen = CategoriesScreen(
      selectedMeals: availableMeals,
    );
    var titleScreen = 'Categories';
    if (indexScreen == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      currentScreen = MealScreen(
        meals: favoriteMeals,
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
