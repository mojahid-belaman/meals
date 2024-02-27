import 'package:flutter/material.dart';
import 'package:meals/dummy_data/categories.dart';
import 'package:meals/modals/category.dart';
import 'package:meals/modals/meal.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.selectedMeals});
  final List<Meal> selectedMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filterMeals = selectedMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return MealScreen(
            title: category.title,
            meals: filterMeals,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in categories)
          CategoryItem(
            category: category,
            onSelectedCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
