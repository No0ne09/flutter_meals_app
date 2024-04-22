import 'package:flutter/material.dart';

class MealItemMeta extends StatelessWidget {
  const MealItemMeta({super.key, required this.icon, required this.text});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        )
      ],
    );
  }
}
