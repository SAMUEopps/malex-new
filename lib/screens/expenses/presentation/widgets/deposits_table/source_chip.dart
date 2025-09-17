import 'package:flutter/material.dart';
import 'package:malex_new/screens/expenses/data/helpers/source_color.dart';
class SourceChip extends StatelessWidget {
  final String source;

  const SourceChip({required this.source});
  @override
  Widget build(BuildContext context) {
    final color = sourceColor(source);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(source,
          style: TextStyle(
              color: color, fontWeight: FontWeight.w500, fontSize: 12)),
    );
  }
}