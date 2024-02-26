import 'package:flutter/material.dart';
import 'package:meals/modals/meal.dart';
import 'package:meals/widgets/meal_section.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(
      {super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                onToggleFavorite(meal);
              },
              icon: const Icon(Icons.favorite))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            const SizedBox(
              height: 15,
            ),
            MealSection(title: 'Ingredients', description: meal.ingredients),
            const SizedBox(
              height: 15,
            ),
            MealSection(title: 'Steps', description: meal.steps),
          ],
        ),
      ),
    );
  }
}
