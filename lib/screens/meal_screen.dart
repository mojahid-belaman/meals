import 'package:flutter/material.dart';
import 'package:meals/modals/meal.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealScreen extends StatelessWidget {
  const MealScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onToggleFavorite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return MealDetailScreen(
            meal: meal,
            onToggleFavorite: onToggleFavorite,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Could not load the meals',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Try Selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground))
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              meal: meals[index],
              onSelectMeal: _selectMeal,
            );
          });
    }

    if (title == null) return content;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
