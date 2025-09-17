import 'package:flutter/material.dart';
class CategoryChip extends StatelessWidget {
  final String category;
  final Color color;

  const CategoryChip({required this.category, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(category,
          style: TextStyle(
              color: color, fontWeight: FontWeight.w500, fontSize: 12)),
    );
  }
}