import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_animate/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends Notifier<Map<Filter, bool>> {
  @override
  build() {
    return {
      Filter.glutenFree: false,
      Filter.lactoseFree: false,
      Filter.vegan: false,
      Filter.vegetarian: false,
    };
  }

  void toggleFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void toggleFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    NotifierProvider<FiltersNotifier, Map<Filter, bool>>(FiltersNotifier.new);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(dummyMealsProvider);
  final pickedFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (pickedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (pickedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (pickedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (pickedFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
