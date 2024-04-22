import 'package:flutter/material.dart';
import 'package:navigation_animate/data/dummy_data.dart';
import 'package:navigation_animate/models/category.dart';
import 'package:navigation_animate/models/meal.dart';
import 'package:navigation_animate/screens/meals.dart';

import 'package:navigation_animate/widgets/cat_grid_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 1,
    );
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = [
      ...widget.availableMeals.where(
        (meal) => meal.categories.contains(category.id),
      ),
    ];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: _animationController, curve: Easing.emphasizedAccelerate),
        ),
        child: widget,
      ),
      child: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...availableCategories.map(
            (category) => CatGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                }),
          ),
        ],
      ),
    );
  }
}
