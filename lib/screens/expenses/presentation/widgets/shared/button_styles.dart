import 'package:flutter/material.dart';
class ButtonStyles {
  static final outlined = OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF2C3E50),
    side: const BorderSide(color: Color(0xFFDCE0E3)),
  );
  static final primary = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF3498DB),
    foregroundColor: Colors.white,
  );
  static final success = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2ECC71),
    foregroundColor: Colors.white,
  );
}