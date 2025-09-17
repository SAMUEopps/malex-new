import 'package:flutter/material.dart';
class IconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const IconBtn(this.icon, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(icon, size: 18, color: color), onPressed: onTap);
  }
}