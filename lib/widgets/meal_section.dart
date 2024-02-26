import 'package:flutter/material.dart';

class MealSection extends StatelessWidget {
  const MealSection(
      {super.key, required this.title, required this.description});

  final String title;
  final List<String> description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        for (final ingredient in description)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              ingredient,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
      ],
    );
  }
}
