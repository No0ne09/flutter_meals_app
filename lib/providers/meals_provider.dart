import 'package:navigation_animate/data/dummy_data.dart';
import 'package:navigation_animate/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dummyMealsProvider = Provider<List<Meal>>((ref) => dummyMeals);
