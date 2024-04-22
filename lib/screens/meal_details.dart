import 'package:flutter/material.dart';
import 'package:navigation_animate/models/meal.dart';
import 'package:navigation_animate/providers/fav_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(favMealsProvider);
    final status = meals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final added =
                  ref.read(favMealsProvider.notifier).toggleMeal(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(added ? "Meal added" : "Meal deleted"),
                ),
              );
            },
            icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween<double>(begin: 0.5, end: 1).animate(animation),
                    child: child,
                  );
                },
                child: Icon(
                  status ? Icons.star : Icons.star_border,
                  key: ValueKey(status),
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
              ),
            ),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            for (final ingredient in meal.ingredients) ...[
              Text(
                ingredient,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 7,
              )
            ],
            const SizedBox(
              height: 15,
            ),
            Text("Steps",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 15,
            ),
            for (final step in meal.steps) ...[
              Text(
                step,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 7,
              )
            ],
          ],
        ),
      ),
    );
  }
}
