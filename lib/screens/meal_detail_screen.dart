import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/modals/meal.dart';
import 'package:meals/providers/favorite_provider.dart';
import 'package:meals/widgets/meal_section.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealProvider);
    final isExist = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealProvider.notifier)
                    .toggleFavoriteMeal(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      wasAdded ? "Meal added as a favorite" : "Meal removed!"),
                  duration: const Duration(seconds: 1),
                ));
              },
              icon: Icon(
                  isExist ? Icons.favorite : Icons.favorite_border_outlined))
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
