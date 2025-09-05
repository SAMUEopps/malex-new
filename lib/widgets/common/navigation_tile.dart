import 'package:malex_new/app/app.dart';
import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  final NavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? const Color(0xFFEBF5FB) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: isSelected
                  ? const Color(0xFF3498DB)
                  : const Color(0xFF7F8C8D),
            ),
            const SizedBox(width: 12),
            Text(
              item.title,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF3498DB)
                    : const Color(0xFF2C3E50),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
