import 'package:flutter/material.dart';

import 'package:navigation_animate/widgets/meal_item_metadata.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:navigation_animate/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectItem});

  final Meal meal;
  final void Function() onSelectItem;

  String get upperComplexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get upperAffordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: onSelectItem,
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemMeta(
                          icon: Icons.schedule_sharp,
                          text: '${meal.duration} min',
                        ),
                        const SizedBox(width: 10),
                        MealItemMeta(
                          icon: Icons.attach_money_outlined,
                          text: upperAffordability,
                        ),
                        const SizedBox(width: 15),
                        MealItemMeta(
                          icon: Icons.work,
                          text: upperComplexity,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
