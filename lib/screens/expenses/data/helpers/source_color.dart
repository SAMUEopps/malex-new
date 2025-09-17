import 'dart:ui';

Color sourceColor(String source) {
  switch (source) {
    case 'Boss':
      return const Color(0xFF3498DB);
    case 'Sales':
      return const Color(0xFF2ECC71);
    case 'Other':
      return const Color(0xFF9B59B6);
    default:
      return const Color(0xFF7F8C8D);
  }
}