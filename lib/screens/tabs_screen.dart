import 'package:flutter/material.dart';
//import 'package:navigation_river/data/dummy_data.dart';
//import 'package:navigation_river/models/meal.dart';
import 'package:navigation_animate/screens/categories.dart';
import 'package:navigation_animate/screens/filters.dart';
import 'package:navigation_animate/screens/meals.dart';
import 'package:navigation_animate/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_animate/providers/fav_provider.dart';
import 'package:navigation_animate/providers/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _index = 0;

  void _onTabOption(String id) {
    Navigator.of(context).pop();
    if (id == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  void _onChangeIndex(int changedIndex) {
    setState(() {
      _index = changedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = CategoryScreen(
      availableMeals: ref.watch(filteredMealsProvider),
    );
    String barTitle = "Browse categories";

    if (_index == 1) {
      final favFood = ref.watch(favMealsProvider);
      currentWidget = MealsScreen(
        meals: favFood,
      );
      barTitle = "Favorites";
    }
    return Scaffold(
      drawer: MainDrawer(
        onTap: _onTabOption,
      ),
      appBar: AppBar(
        title: Text(barTitle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onChangeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: "Browse food",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Your favourite food",
          ),
        ],
      ),
      body: currentWidget,
    );
  }
}
