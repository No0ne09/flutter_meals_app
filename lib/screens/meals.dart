import 'package:flutter/material.dart';
import 'package:navigation_animate/models/meal.dart';
import 'package:navigation_animate/widgets/meal_item.dart';
import 'package:navigation_animate/screens/meal_details.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  void onSelectItem(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetails(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: widget.meals.length,
      itemBuilder: (context, index) => MealItem(
          meal: widget.meals[index],
          onSelectItem: () {
            onSelectItem(context, widget.meals[index]);
          }),
    );

    if (widget.meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nothing here",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select diffrent category",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }
    if (widget.title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: content,
    );
  }
}
