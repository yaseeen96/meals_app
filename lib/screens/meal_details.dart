import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favourites_provider.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({
    super.key,
    required this.meal,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);

    final isFavourite = favouriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(meal);
            },
            icon: Icon(isFavourite ? Icons.star : Icons.star_border),
            color: Colors.amber,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(
            meal.imageUrl,
            height: 300,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            "Ingredients",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 14,
          ),
          for (final ingredient in meal.ingredients)
            Text(
              ingredient,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Steps",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 14,
          ),
          for (final steps in meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Text(
                steps,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
        ]),
      ),
    );
  }
}
