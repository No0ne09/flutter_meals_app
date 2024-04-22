import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_animate/models/meal.dart';

class FavMealsNotifier extends Notifier<List<Meal>> {
  @override
  build() {
    return [];
  }

  bool toggleMeal(Meal meal) {
    final contains = state.contains(meal);

    if (contains) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favMealsProvider =
    NotifierProvider<FavMealsNotifier, List<Meal>>(FavMealsNotifier.new);
