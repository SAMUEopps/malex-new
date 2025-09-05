import 'package:malex_new/app/app.dart';
import 'package:flutter/material.dart';

class DashboardCardWidget extends StatelessWidget {
  final DashboardCard card;

  const DashboardCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            card.icon,
            color: card.color,
            size: 24,
          ),
          const SizedBox(height: 12),
          Text(
            card.title,
            style: const TextStyle(
              color: Color(0xFF7F8C8D),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'KSh 12,450',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }
}