import 'package:flutter/material.dart';

class TimeWindowCard extends StatelessWidget {
  final String time;
  final String label;
  final Color color;
  final IconData icon;

  const TimeWindowCard({
    super.key,
    required this.time,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(time,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700, color: color)),
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF5A6C7D))),
            ],
          ),
        ],
      ),
    );
  }
}